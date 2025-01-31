FROM ubuntu:20.04

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip xvfb ffmpeg curl git build-essential tzdata openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set the time zone to UTC
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Install Rust and Cargo using rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Clone the Ruffle repository
RUN git clone https://github.com/ruffle-rs/ruffle.git /ruffle

# Set the working directory
WORKDIR /ruffle

# Build the Ruffle exporter
RUN cargo build --release --package=exporter

# Create a directory for data
RUN mkdir /data
WORKDIR /data

# Add the conversion script to the container
ADD swf_to_mp4.sh /swf_to_mp4.sh
RUN chmod +x /swf_to_mp4.sh

# Set the entrypoint to the conversion script
ENTRYPOINT ["/swf_to_mp4.sh"]
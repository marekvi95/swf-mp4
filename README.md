# swf-mp4

SWF to MP4 converter

## Overview

This project provides a Dockerized solution to convert SWF files to MP4 videos using the Ruffle exporter and FFmpeg. The conversion process involves exporting frames from the SWF file and then encoding these frames into an MP4 video.

## Prerequisites

- Docker

## Getting Started

### Building the Docker Image

To build the Docker image, run the following command in the directory containing the `Dockerfile`:

```sh
docker build -t swf-mp4 .
```

### Running the Conversion

To convert a SWF file to an MP4 video, run the following command:

```sh
docker run --rm -v /path/to/data:/data -e SWFFILE=/data/input.swf -e MP4FILE=/data/output.mp4 swf-mp4
```

Replace `/path/to/data`, `input.swf`, and `output.mp4` with the appropriate paths and filenames.

### Environment Variables

- `SWFFILE`: The path to the input SWF file.
- `MP4FILE`: The path to the output MP4 video file.
- `FRAMES`: The number of frames to export from the SWF file (default: 2000.)

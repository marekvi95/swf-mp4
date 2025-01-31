#!/bin/bash

set -e

# Input file and frames count from environment variables
SWFFILE=${SWFFILE:-/data/input.swf}
IMGDIR=${IMGDIR:-/data/screenshots}
MP4FILE=${MP4FILE:-/data/output.mp4}
FRAMES=${FRAMES:-2000}

# Ensure the image directory exists
mkdir -p "$IMGDIR"

# Change to the Ruffle directory to run the exporter
cd /ruffle

# Export frames using Ruffle exporter
echo "Exporting frames from $SWFFILE to $IMGDIR"
cargo run --release --package=exporter -- "$SWFFILE" "$IMGDIR" --frames "$FRAMES"

# Change back to the data directory
cd /data

# Convert frames to video
echo "Converting frames in $IMGDIR to video $MP4FILE"
ffmpeg -y -framerate 24 -i "$IMGDIR/%d.png" -c:v libx264 -pix_fmt yuv420p -r 24 "$MP4FILE"

echo "Done."
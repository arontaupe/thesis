#!/bin/bash

# Check if the script is already running
if pgrep -f "archive_pipeline.py" > /dev/null; then
    echo "Scan already in progress. Ignoring new request."
    exit 1
fi

# Check if Logseq is running
if ! pgrep -x "Logseq" > /dev/null; then
    echo "⚠️  Logseq is not running. Starting Logseq..."
    open -a "Logseq"
else
    echo "✅ Logseq is running, continuing..."
fi

echo "Scanning to Archive"

cd ~/thesis/code || exit

# Activate virtual environment
source ~/thesis/code/.venv/bin/activate

# Default camera index is 0
CAMERA_INDEX=0

# Check if a camera index was provided as an argument
if [ ! -z "$1" ]; then
    CAMERA_INDEX=$1
fi

echo "Starting scan with camera index $CAMERA_INDEX..."
~/thesis/code/.venv/bin/python ~/thesis/code/archive_pipeline.py --camera "$CAMERA_INDEX"

echo "Scan Complete"

echo "Type 'scan' and hit enter to trigger an upload. You can also type 'scan --help' for more options."
echo "Start the *Scan to Archive* App if unsure."
exit 0
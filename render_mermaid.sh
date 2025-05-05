#!/bin/bash

# Ensure Mermaid CLI is installed
if ! command -v mmdc &> /dev/null
then
    echo "Mermaid CLI (mmdc) not found. Install it with: npm install -g @mermaid-js/mermaid-cli"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p typst/assets/images

# Loop through all .mmd files in the mermaid folder
for file in typst/assets/mermaid/*.mmd; do
    # Extract filename without extension
    filename=$(basename -- "$file" .mmd)

    # Convert to PNG
    echo "Rendering $file -> typst/assets/images/$filename.png"
    mmdc -i "$file" -o "typst/assets/images/$filename.png" -t neutral -b transparent -s 3

    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "Successfully rendered: $filename.png"
    else
        echo "Failed to render: $filename.png"
    fi
done

echo "All Mermaid diagrams processed!"

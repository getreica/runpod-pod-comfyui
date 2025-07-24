#!/bin/bash
set -euo pipefail

# Some custom nodes need this env variable
COMFYUI_PATH=/comfyui

# File containing the list of nodes to download
NODES_FILE="/node_list.txt"

# Validate nodes file exists
if [[ ! -f "$NODES_FILE" ]]; then
    echo "Error: Node list file $NODES_FILE not found" >&2
    exit 1
fi

# Directory where nodes will be downloaded
DOWNLOAD_DIR="$COMFYUI_PATH/custom_nodes"
echo "Nodes will be downloaded to $DOWNLOAD_DIR"

# Create download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR" || {
    echo "Error: Failed to create directory $DOWNLOAD_DIR" >&2
    exit 1
}

cd "$DOWNLOAD_DIR" || {
    echo "Error: Failed to enter directory $DOWNLOAD_DIR" >&2
    exit 1
}

# Read each node from the text file
while IFS= read -r GITHUB_URL || [[ -n "$GITHUB_URL" ]]; do
    GITHUB_URL=$(echo "$GITHUB_URL" | xargs)  # Trim whitespace
    if [[ -z "$GITHUB_URL" || "$GITHUB_URL" == \#* ]]; then
        continue  # Skip empty lines and comments
    fi

    NODE_NAME=$(basename "$GITHUB_URL")
    
    echo "Downloading node: $GITHUB_URL"
    
    if [[ -d "$DOWNLOAD_DIR/$NODE_NAME" ]]; then
        echo "Node $NODE_NAME already exists, skipping."
        continue
    fi
    
    if ! git clone "$GITHUB_URL" --recursive; then
        echo "Error: Failed to clone $GITHUB_URL" >&2
        continue
    fi
    
    if [[ -f "$DOWNLOAD_DIR/$NODE_NAME/requirements.txt" ]]; then
        echo "Installing dependencies for $NODE_NAME"
        if ! pip3 install -r "$DOWNLOAD_DIR/$NODE_NAME/requirements.txt"; then
            echo "Warning: Failed to install dependencies for $NODE_NAME" >&2
        fi
    else
        echo "requirements.txt not found for $NODE_NAME, skipping."
    fi
done < "$NODES_FILE"

echo "Process completed successfully."
exit 0

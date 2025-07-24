#!/bin/bash
set -e  # Exit immediately if a command exits with non-zero status

# Ensure we have /workspace in all scenarios
mkdir -p /workspace || { echo "Failed to create /workspace"; exit 1; }

# Install base nodes
cd /comfyui || { echo "Failed to cd to /comfyui"; exit 1; }

# remove models
echo "------- Linking /workspace/comfyui/models folder into Comfyui -------"
rm -rf /comfyui/models
ln -s /workspace/models /comfyui/ || { echo "Failed to create models symlink"; exit 1; }

# Copy the bodytypes folder into input folder
echo "------- Linking /workspace/bodytypes into Comfyui input folder -------"
mkdir -p /comfyui/input/bodytypes || { echo "Failed to create bodytypes directory"; exit 1; }
cp -r /workspace/bodytypes /comfyui/input/ || { echo "Failed to copy bodytypes"; exit 1; }

# Start download nodes in /workspace/custom_nodes 
# Download all custom nodes in /workspace/custom_nodes
echo "------- Installing all nodes -------"
chmod 755 /4-download-custom-nodes.sh || { echo "Failed to chmod download script"; exit 1; }
/4-download-custom-nodes.sh || { echo "Custom nodes download failed"; exit 1; }

# Update default settings
echo "------- Update Comfyui Settings -------"
mv /comfy.settings.json /comfyui/comfy.settings.json || { echo "Failed to move settings file"; exit 1; }
python3 /replaceDefaultGraph.py || { echo "Failed to update default graph"; exit 1; }



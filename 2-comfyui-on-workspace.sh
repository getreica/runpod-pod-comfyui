#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

# Install base nodes
cd /comfyui

# remove models
echo "------- Linking /workspace/comfyui/models folder into Comfyui -------"
rm -rf /comfyui/models
ln -s /workspace/models /comfyui/

# Copy the bodytypes folder into input folder
echo "------- Linking /workspace/bodytypes into Comfyui input folder -------"
mkdir -p /comfyui/input/bodytypes
cp -r /workspace/bodytypes /comfyui/input/bodytypes

# Start download nodes in /workspace/custom_nodes 
# Download all custom nodes in /workspace/custom_nodes
echo "------- Installing all nodes -------"
chmod 755 /4-download-custom-nodes.sh
/4-download-custom-nodes.sh

# Update default settings
echo "------- Update Comfyui Settings -------"
mv /comfy.settings.json /comfyui/comfy.settings.json
python3 /replaceDefaultGraph.py



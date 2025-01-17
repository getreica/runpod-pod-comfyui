#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

# Install base nodes
cd /comfyui

# remove models
echo "------- Linking /workspace/comfyui/models folder into Comfyui -------"
rm -rf /workspace/comfyui/models
ln -s /workspace/models /workspace/comfyui/models

echo "------- Installing custom scripts -------"
comfy node install https://github.com/pythongosssss/ComfyUI-Custom-Scripts

# Start download nodes in /workspace/custom_nodes 
# Download all custom nodes in /workspace/custom_nodes
echo "------- Installing all nodes -------"
chmod 755 /download-custom-nodes.sh
/download-custom-nodes.sh

# Update default settings
echo "------- Update Comfyui Settings -------"
mv /comfy.settings.json /comfyui/comfy.settings.json
python3 /replaceDefaultGraph.py



#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

# Install base nodes
cd /comfyui
comfy node install https://github.com/pythongosssss/ComfyUI-Custom-Scripts

# Start download nodes in /workspace/custom_nodes 
# Download all custom nodes in /workspace/custom_nodes
chmod 755 /download-custom-nodes.sh
/download-custom-nodes.sh

# Update default settings
mv /comfy.settings.json /comfyui/comfy.settings.json
python3 /replaceDefaultGraph.py

# remove models
rm -rf /workspace/ComfyUI/models
ln -s /workspace/models /workspace/comfyui/models

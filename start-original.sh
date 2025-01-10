#!/bin/bash

# You can make modifications to this file if you want to customize the startup process.
# Things like installing additional custom nodes, or downloading models can be done here.

# Launch the UI
cd /comfyui
python3 main.py --listen

# Keep the container running indefinitely
sleep infinity

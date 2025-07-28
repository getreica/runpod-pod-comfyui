#!/bin/bash

echo "POD started"

echo "----------------- Check Env variables -----------------"
/1-check-variables.sh

# Move text-generation-webui's folder to $VOLUME so models and all config will persist
# Download or do nothing
echo "----------------- Check install custom nodes and link models folder -----------------"
/2-comfyui-on-workspace.sh

# Move ai-toolkit's folder to $VOLUME so models and all config will persist
# Download or do nothing
echo "----------------- AI Toolkit on workspace -----------------"
/3-ai-toolkit-on-workspace.sh

# Start nginx as reverse proxy to enable api access
service nginx start

# Start JupyterLab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.allow_origin='*' &
echo "----------------- JupyterLab started -----------------"

# Check if user's script exists in /workspace
if [ ! -f /start_user.sh ]; then
    # If not, copy the original script to /workspace
    cp /start-original.sh /start_user.sh
fi

# Execute the user's script
bash /start_user.sh
#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ai-toolkit ]]; then
    echo "----- Installing Ai Toolkit ------"
    cd / && \
    git clone https://github.com/ostris/ai-toolkit.git && \
    cd ai-toolkit && \
    git submodule update --init --recursive && \
    pip3 install -r requirements.txt

    # Then link /ai-toolkit folder to /workspace
    mv /ai-toolkit /workspace/ai-toolkit
    ln -sf /workspace/ai-toolkit /ai-toolkit

    # Create directories if they don't exist
    mkdir -p /workspace/ai-toolkit/{training_set,LoRas}
    mkdir -p /workspace/models/loras/ai_toolkit_train

    # Create symlinks with force flag to avoid errors if they exist
    ln -sf /workspace/ai-toolkit/output /workspace/models/loras/ai_toolkit_train
    ln -sf /workspace/ai-toolkit/LoRas /workspace/models/loras/ai-toolkit

    # Install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    \. "$HOME/.nvm/nvm.sh"

    # Install Node.js
    nvm install 22
    echo "Node.js version: $(node -v)"
    echo "npm version: $(npm -v)"

    cd /workspace/ai-toolkit/ui
    npm run build_and_start

else
    echo "----- Ai Toolkit already installed at /workspace/ai-toolkit ------"
    ln -sf /workspace/ai-toolkit /ai-toolkit
    cd /workspace/ai-toolkit/ui

    # Install Node.js
    nvm install 22
    echo "Node.js version: $(node -v)"
    echo "npm version: $(npm -v)"
    
    # Ensure the build and start script is run
    npm run build_and_start
fi
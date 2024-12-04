ARG CUDA_VERSION="12.1.1"
ARG CUDNN_VERSION="8"
ARG UBUNTU_VERSION="22.04"
ARG DOCKER_FROM=nvidia/cuda:$CUDA_VERSION-cudnn$CUDNN_VERSION-devel-ubuntu$UBUNTU_VERSION

# Base NVidia CUDA Ubuntu image
FROM $DOCKER_FROM AS base

# Install Python plus openssh, which is our minimum set of required packages.
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get install -y --no-install-recommends openssh-server openssh-client git git-lfs wget vim zip unzip curl && \
    python3 -m pip install --upgrade pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install nginx
RUN apt-get update && \
    apt-get install -y nginx && \ 
    apt-get install build-essential -y && \
    apt-get install clang -y

# Install pget https://github.com/replicate/pget
RUN curl -o /usr/local/bin/pget -L "https://github.com/replicate/pget/releases/latest/download/pget_$(uname -s)_$(uname -m)" && \ 
    chmod +x /usr/local/bin/pget

# Copy the 'default' configuration file to the appropriate location
COPY default /etc/nginx/sites-available/default

# Shell path for CUDA
ENV PATH="/usr/local/cuda/bin:${PATH}"

# Install pytorch
ARG PYTORCH="2.4.0"
ARG CUDA="121"
RUN pip3 install --no-cache-dir -U torch==$PYTORCH torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu$CUDA

# Script for run ComfyUI in Listen 
COPY --chmod=755 start-ssh-only.sh /start.sh
COPY --chmod=755 start-original.sh /start-original.sh
# Setup environment ComfyUI and Ai Toolkit 
COPY --chmod=755 comfyui-on-workspace.sh /comfyui-on-workspace.sh
COPY --chmod=755 ai-toolkit-on-workspace.sh /ai-toolkit-on-workspace.sh

# Setup script of ComfyUI settings
COPY --chmod=644 comfy.settings.json /ComfyUI/user/default/comfy.settings.json

WORKDIR /workspace

EXPOSE 8188

# Install PIP modules for custom nodes 
# Layerstyle 
RUN pip install inference-cli==0.17.0 facexlib colorama gguf blend-modes xformers


#
# Change default workflow on ComfyUI startup
# This is a hacky way to change the default workflow on startup, but it works
# 
COPY --chmod=644 defaultGraph.json /defaultGraph.json
COPY --chmod=755 replaceDefaultGraph.py /replaceDefaultGraph.py
# Run the Python script
RUN python3 /replaceDefaultGraph.py



# Install Xlabs-AI/flux-RealismLora
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0

# This is a hacky way to change the default workflow on startup, but it works
COPY --chmod=644 defaultGraph.json /defaultGraph.json
COPY --chmod=755 replaceDefaultGraph.py /replaceDefaultGraph.py
# Run the Python script
RUN python3 /replaceDefaultGraph.py

# Add Jupyter Notebook
RUN pip3 install jupyterlab
EXPOSE 8888

# copy default train_lora.yaml file
COPY --chmod=644 ai-toolkit/train_lora.yaml /ai-toolkit/config/train_lora.yaml
COPY --chmod=755 ai-toolkit/caption_images.py /caption_images.py
EXPOSE 7860

CMD [ "/start.sh" ]
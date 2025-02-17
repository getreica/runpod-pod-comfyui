ARG CUDA_VERSION="12.1.1"
ARG CUDNN_VERSION="8"
ARG UBUNTU_VERSION="22.04"
ARG DOCKER_FROM=nvidia/cuda:$CUDA_VERSION-cudnn$CUDNN_VERSION-devel-ubuntu$UBUNTU_VERSION

# Base NVidia CUDA Ubuntu image
FROM $DOCKER_FROM AS base

# Install Python, git and other necessary tools
RUN apt-get update && apt-get install -y \
    python3.11 -y \
    python3-pip \
    && apt-get install -y --no-install-recommends git git-lfs wget curl zip unzip aria2 ffmpeg libxext6 libxrender1 \
    && apt-get install -y libgl1-mesa-glx libglib2.0-0 git wget libgl1 \
    && ln -sf /usr/bin/python3.11 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip

# Clean up to reduce image size
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install comfy-cli
RUN pip install comfy-cli

# Install ComfyUI
RUN /usr/bin/yes | comfy --workspace /comfyui install --cuda-version 12.1 --nvidia --version 0.3.14

FROM base AS comfyui

WORKDIR /

# Install pget https://github.com/replicate/pget
RUN curl -o /usr/local/bin/pget -L "https://github.com/replicate/pget/releases/latest/download/pget_$(uname -s)_$(uname -m)" && \ 
    chmod +x /usr/local/bin/pget

# Copy the 'default' configuration file to the appropriate location
COPY default /etc/nginx/sites-available/default

# Shell path for CUDA
ENV PATH="/usr/local/cuda/bin:${PATH}"

# Script for run ComfyUI in Listen 
COPY --chmod=755 start-ssh-only.sh /start.sh
COPY --chmod=755 start-original.sh /start-original.sh
# Setup environment ComfyUI and Ai Toolkit 
COPY --chmod=755 1-check-variables.sh /1-check-variables.sh
COPY --chmod=755 2-comfyui-on-workspace.sh /2-comfyui-on-workspace.sh
COPY --chmod=755 3-ai-toolkit-on-workspace.sh /3-ai-toolkit-on-workspace.sh
COPY --chown=755 download-custom-nodes.sh /download-custom-nodes.sh

# Setup script of ComfyUI settings
COPY --chmod=644 comfy.settings.json /comfy.settings.json
#
# Change default workflow on ComfyUI startup
# This is a hacky way to change the default workflow on startup, but it works
# 
COPY --chmod=644 defaultGraph.json /defaultGraph.json
COPY --chmod=755 replaceDefaultGraph.py /replaceDefaultGraph.py

EXPOSE 8188

FROM comfyui AS ai-toolkit

WORKDIR /

# Install PIP modules for custom nodes 
# Layerstyle 
RUN pip3 install inference-cli==0.17.0 facexlib colorama gguf blend-modes xformers insightface huggingface_hub[cli,torch]

# Add Jupyter Notebook
RUN pip3 install jupyterlab
EXPOSE 8888

# copy default train_lora.yaml file
COPY --chmod=644 ai-toolkit/train_lora.yaml /ai-toolkit/config/train_lora.yaml
COPY --chmod=755 ai-toolkit/caption_images.py /caption_images.py
EXPOSE 7860

CMD [ "/start.sh" ]
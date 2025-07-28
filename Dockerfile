# syntax=docker/dockerfile:1
ARG CUDA_VERSION="12.8.1"
ARG UBUNTU_VERSION="22.04"
ARG DOCKER_FROM=nvidia/cuda:$CUDA_VERSION-cudnn-devel-ubuntu$UBUNTU_VERSION

# Base NVidia CUDA Ubuntu image
FROM $DOCKER_FROM AS base

# Set environment variables early
ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/usr/local/cuda/bin:/opt/venv/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies in one layer with cache mount
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.11 \
        python3.11-venv \
        python3.10-venv \
        python3-pip \
        git \
        git-lfs \
        wget \
        curl \
        zip \
        unzip \
        aria2 \
        ffmpeg \
        libxext6 \
        libxrender1 \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libgl1 \
        ca-certificates && \
    ln -sf /usr/bin/python3.11 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /tmp/* /var/tmp/*

# Install pget and copy nginx config in one layer
RUN curl -o /usr/local/bin/pget -L "https://github.com/replicate/pget/releases/latest/download/pget_$(uname -s)_$(uname -m)" && \
    chmod +x /usr/local/bin/pget

# Copy the 'default' configuration file to the appropriate location
COPY default /etc/nginx/sites-available/default

# Create and activate Python virtual environment
RUN python3.11 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip setuptools wheel

#
#   PyTorch Installation for RTX 5090
# 
FROM base AS pytorch

# Install PyTorch with cache mount for pip
RUN --mount=type=cache,target=/root/.cache/pip \
    /opt/venv/bin/pip install --pre torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/nightly/cu128

#
#   ComfyUI Installation
#
FROM pytorch AS comfyui

# Install comfy-cli and ComfyUI with cache mount
RUN --mount=type=cache,target=/root/.cache/pip \
    /opt/venv/bin/pip install comfy-cli && \
    /usr/bin/yes | /opt/venv/bin/comfy --workspace /comfyui install --cuda-version 12.6 --nvidia --version 0.3.46

EXPOSE 8188

#
# JupyterLab + AI Toolkit
#
FROM comfyui AS ai-toolkit

# Install JupyterLab and create AI Toolkit directory structure
RUN --mount=type=cache,target=/root/.cache/pip \
    /opt/venv/bin/pip install jupyterlab && \
    mkdir -p /ai-toolkit/config

# Copy AI Toolkit configuration files
COPY --chmod=644 ai-toolkit/train_lora.yaml /ai-toolkit/config/train_lora.yaml
COPY --chmod=755 ai-toolkit/caption_images.py /caption_images.py

EXPOSE 8888 8675

#
#   Final Production Image
#
FROM ai-toolkit AS final

WORKDIR /

# Copy all startup and configuration scripts in one layer
COPY --chmod=755 start-ssh-only.sh /start.sh
COPY --chmod=755 start-original.sh /start-original.sh
COPY --chmod=755 1-check-variables.sh /1-check-variables.sh
COPY --chmod=755 2-comfyui-on-workspace.sh /2-comfyui-on-workspace.sh
COPY --chmod=755 3-ai-toolkit-on-workspace.sh /3-ai-toolkit-on-workspace.sh
COPY --chmod=755 4-download-custom-nodes.sh /4-download-custom-nodes.sh
COPY --chmod=644 comfy.settings.json /comfyui/comfy.settings.json
COPY --chmod=644 node_list.txt /node_list.txt

# Create necessary directories and set proper permissions
RUN mkdir -p /workspace /tmp && \
    chmod -R 755 /workspace

# Health check for ComfyUI
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8188/ || exit 1

# Use exec form for better signal handling
CMD ["/start.sh"]
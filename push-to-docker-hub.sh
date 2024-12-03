#!/usr/bin/env bash

TAG_NAME=1.0.4

# build with latest tag
docker build -t alexgenovese/runpod-pod-comfyui:${TAG_NAME} --platform linux/amd64 .

# Publish on hub 
docker push alexgenovese/runpod-pod-comfyui:${TAG_NAME}
#!/bin/bash
set -euo pipefail

if [[ $PUBLIC_KEY ]]
then
    echo "Setting up SSH..."
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
    if ! service ssh start; then
        echo "Failed to start SSH service" >&2
        exit 1
    fi
fi

if [[ -z "${HF_TOKEN}" ]] || [[ "${HF_TOKEN}" == "enter_your_huggingface_token_here" ]]
then
    echo "HF_TOKEN is not set"
else
    echo "HF_TOKEN is set, logging in..."
    if ! huggingface-cli login --token "${HF_TOKEN}"; then
        echo "Failed to login to Hugging Face" >&2
        exit 1
    fi
fi
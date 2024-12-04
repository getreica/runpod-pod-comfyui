#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ComfyUI ]]; then
	echo "----- Installing ComfyUI ------"
	# If we don't already have /workspace/ComfyUI
	# Download it
	git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip3 install -r requirements.txt && \
    cd custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git && \
    cd /ComfyUI && \
    mkdir pysssss-workflows

	# Move to workspace 
	mv /ComfyUI /workspace

	# remove models
	rm -rf /workspace/ComfyUI/models
	ln -s /workspace/models /workspace/ComfyUI/models

	# remove, create the folder on storage and link to custom_nodes
	mv /workspace/ComfyUI/custom_nodes /workspace/custom_nodes
	ln -s /workspace/custom_nodes /workspace/ComfyUI/custom_nodes

	# Then link /ComfyUI folder to /workspace so it's available in that familiar location as well
	ln -s /workspace/ComfyUI /ComfyUI

else
	echo "----- No Installation required. ComfyUI is on /workspace/ComfyUI ------"
	# 
	# check if the link to custom_nodes was there
	if [[ ! -d /workspace/custom_nodes ]]; then
		# it doesn't exists yet so move and link
		mv /workspace/ComfyUI/custom_nodes /workspace/custom_nodes
		ln -s /workspace/custom_nodes /workspace/ComfyUI/custom_nodes
	fi
fi
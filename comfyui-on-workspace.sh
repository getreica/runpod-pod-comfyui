#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ComfyUI ]]; then
	echo "----- Installing ComfyUI ------"
	# If we don't already have /workspace/ComfyUI
	# Download it
	cd / && \
	git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip3 install -r requirements.txt && \
    cd custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git && \
    cd /ComfyUI && \
    mkdir pysssss-workflows
	
	# Update default settings
	mv /comfy.settings.json /ComfyUI/comfy.settings.json
	python3 /replaceDefaultGraph.py

	# Start download nodes in /workspace/custom_nodes 
	# Download all custom nodes in /workspace/custom_nodes
	chmod 755 /download-custom-nodes.sh
	/download-custom-nodes.sh

	# Then link /workspace/ComfyUI folder to /workspace so it's available in that familiar location as well
	mv /ComfyUI /workspace/ComfyUI
	ln -s /workspace/ComfyUI /ComfyUI

	# remove models
	rm -rf /workspace/ComfyUI/models
	ln -s /workspace/models /workspace/ComfyUI/models

	# remove, create the folder on storage and link to custom_nodes
	mv /workspace/ComfyUI/custom_nodes /workspace/custom_nodes
	ln -s /workspace/custom_nodes /workspace/ComfyUI/custom_nodes
	

else
	echo "----- No Installation required. ComfyUI is on /workspace/ComfyUI ------"
	# Just recreate the custom nodes only
	echo "Creating Link on /"
	ln -s /workspace/ComfyUI /ComfyUI

	echo "Update the git to latest commit" 
	git pull 

	echo "Run pip install"
	pip3 install -r requirements.txt

	echo "Reinstall custom nodes" 
	rm -rf /workspace/custom_nodes

	# Start download nodes in /workspace/custom_nodes 
	# Download all custom nodes in /workspace/custom_nodes
	chmod 755 /download-custom-nodes.sh
	/download-custom-nodes.sh


fi
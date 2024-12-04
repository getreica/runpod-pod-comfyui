#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ai-toolkit ]]; then
	echo "----- Installing Ai Toolkit ------"
	cd /workspace && \
    git clone https://github.com/ostris/ai-toolkit.git && \
    cd ai-toolkit && \
    git submodule update --init --recursive && \
    pip3 install -r requirements.txt

	# Then link /ai-toolkit folder to /workspace so it's available in that familiar location as well
	ln -s /workspace/ai-toolkit /ai-toolkit

	# Ensure we have /workspace/training_sets in all scenarios
	mkdir -p /workspace/training_set
	mkdir -p /workspace/LoRas
	mkdir -p /workspace/models/loras/flux_train_ui

	# when trained using the UI, the result is stored in /workspace/ai-toolkit/output
	ln -s /workspace/ai-toolkit/output /workspace/models/loras/flux_train_ui

	# when trained using the CLI, the result set is stored in /workspace/LoRas (don't put it in /workspace/ai-toolkit/output because it will create a symlink loop)
	ln -s /workspace/LoRas /workspace/models/loras/ai-toolkit

else
	# otherwise – do nothing
	echo "----- No Installation required. Ai Toolkit is on /workspace/ai-toolkit ------"
	# rm -rf /ai-toolkit
fi

#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ai-toolkit ]]; then
	echo "----- Installing Ai Toolkit ------"
	cd / && \
    git clone https://github.com/ostris/ai-toolkit.git && \
    cd ai-toolkit && \
    git submodule update --init --recursive && \
    pip3 install -r requirements.txt

	# Then link /ai-toolkit folder to /workspace so it's available in that familiar location as well
	mv /ai-toolkit /workspace/ai-toolkit
	ln -s /workspace/ai-toolkit /ai-toolkit

	# Ensure we have /workspace/training_sets in all scenarios
	mkdir -p /workspace/ai-toolkit/training_set
	mkdir -p /workspace/ai-toolkit/LoRas
	mkdir -p /workspace/models/loras/ai_toolkit_train

	# when trained using the UI, the result is stored in /workspace/ai-toolkit/output
	ln -s /workspace/ai-toolkit/output /workspace/models/loras/ai_toolkit_train

	# when trained using the CLI, the result set is stored in /workspace/LoRas (don't put it in /workspace/ai-toolkit/output because it will create a symlink loop)
	ln -s /workspace/ai-toolkit/LoRas /workspace/models/loras/ai-toolkit

else
	# otherwise – do nothing
	echo "----- No Installation required. Ai Toolkit is on /workspace/ai-toolkit ------"
	# rm -rf /ai-toolkit
fi

#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ai-toolkit ]]; then
	echo "----- Installing Ai Toolkit ------"
	# If we don't already have /workspace/ai-toolkit, move it there
	mv /ai-toolkit /workspace

	# Then link /ai-toolkit folder to /workspace so it's available in that familiar location as well
	ln -s /workspace/ai-toolkit /ai-toolkit

	# Ensure we have /workspace/training_sets in all scenarios
	mkdir -p /workspace/training_set
	mkdir -p /workspace/LoRas

	# when trained using the UI, the result is stored in /workspace/ai-toolkit/output
	ln -s /workspace/ai-toolkit/output /workspace/ComfyUI/models/loras/flux_train_ui

	# when trained using the CLI, the result set is stored in /workspace/LoRas (don't put it in /workspace/ai-toolkit/output because it will create a symlink loop)
	ln -s /workspace/LoRas /workspace/ComfyUI/models/loras/ai-toolkit

else
	# otherwise – do nothing
	echo "----- No Installation required. Ai Toolkit is on /workspace/ai-toolkit ------"
	# rm -rf /ai-toolkit
fi

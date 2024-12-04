# XLAbs node
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/XLabs-AI/x-flux-comfyui.git && \
cd x-flux-comfyui && \
python3 setup.py

# SUPIR Upscale
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-SUPIR.git && \
cd ComfyUI-SUPIR && \
pip3 install -r requirements.txt

# KJNodes
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
cd ComfyUI-KJNodes && \
pip3 install -r requirements.txt

# rgthree
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/rgthree/rgthree-comfy.git && \
cd rgthree-comfy && \
pip3 install -r requirements.txt

# JPS-Nodes
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/JPS-GER/ComfyUI_JPS-Nodes.git

# Comfyrol Studio
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git

# comfy-plasma
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/Jordach/comfy-plasma.git

# ComfyUI-Impact-Subpack
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
cd ComfyUI-Impact-Pack && \
pip3 install -r requirements.txt && \
python3 install.py

# ComfyUI-Impact-controlnet_aux
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git && \
cd comfyui_controlnet_aux && \
pip3 install -r requirements.txt

# ComfyUI-UltimateSDUpscale
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive

# ComfyUI-Easy-Use
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/yolain/ComfyUI-Easy-Use.git && \
cd ComfyUI-Easy-Use && \
pip3 install -r requirements.txt

# ComfyUI-Florence2
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-Florence2.git && \
cd ComfyUI-Florence2 && \
pip3 install -r requirements.txt && \
mkdir /workspace/ComfyUI/models/LLM

# was-node-suite-comfyui
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && \
cd was-node-suite-comfyui && \
pip3 install -r requirements.txt

# ComfyUI-Logic
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/theUpsider/ComfyUI-Logic.git

# ComfyUI_essentials
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/cubiq/ComfyUI_essentials.git && \
cd ComfyUI_essentials && \
pip3 install -r requirements.txt

# cg-image-picker
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/chrisgoringe/cg-image-picker.git

# ComfyUI_LayerStyle
# pip install inference-cli==0.17.0
# cd /workspace/ComfyUI/custom_nodes && \
#     git clone https://github.com/chflame163/ComfyUI_LayerStyle.git && \
#     cd ComfyUI_LayerStyle && \
#     pip3 install -r requirements.txt

# comfyui-reactor-node
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/Gourieff/comfyui-reactor-node.git && \
cd comfyui-reactor-node && \
pip3 install -r requirements.txt

# cg-use-everywhere
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/chrisgoringe/cg-use-everywhere.git

# ComfyUI-CogVideoXWrapper
cd /workspace/ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-CogVideoXWrapper.git && \
cd ComfyUI-CogVideoXWrapper && \
pip3 install -r requirements.txt
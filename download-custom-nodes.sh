# Some custom nodes need this env variable
COMFYUI_PATH=/ComfyUI

# XLAbs node
cd /ComfyUI/custom_nodes && \
git clone https://github.com/XLabs-AI/x-flux-comfyui.git && \
cd x-flux-comfyui && \
python3 setup.py

# SUPIR Upscale
cd /ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-SUPIR.git && \
cd ComfyUI-SUPIR && \
pip3 install -r requirements.txt

# KJNodes
cd /ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
cd ComfyUI-KJNodes && \
pip3 install -r requirements.txt

# rgthree
cd /ComfyUI/custom_nodes && \
git clone https://github.com/rgthree/rgthree-comfy.git && \
cd rgthree-comfy && \
pip3 install -r requirements.txt

# JPS-Nodes
cd /ComfyUI/custom_nodes && \
git clone https://github.com/JPS-GER/ComfyUI_JPS-Nodes.git

# Comfyrol Studio
cd /ComfyUI/custom_nodes && \
git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git

# comfy-plasma
cd /ComfyUI/custom_nodes && \
git clone https://github.com/Jordach/comfy-plasma.git

# ComfyUI-Impact-Subpack
cd /ComfyUI/custom_nodes && \
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
cd ComfyUI-Impact-Pack && \
pip3 install -r requirements.txt && \
python3 install.py

# ComfyUI-Impact-controlnet_aux
cd /ComfyUI/custom_nodes && \
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git && \
cd comfyui_controlnet_aux && \
pip3 install -r requirements.txt

# ComfyUI-UltimateSDUpscale
cd /ComfyUI/custom_nodes && \
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive

# ComfyUI-Easy-Use
cd /ComfyUI/custom_nodes && \
git clone https://github.com/yolain/ComfyUI-Easy-Use.git && \
cd ComfyUI-Easy-Use && \
pip3 install -r requirements.txt

# ComfyUI-Florence2
cd /ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-Florence2.git && \
cd ComfyUI-Florence2 && \
pip3 install -r requirements.txt && \
mkdir /ComfyUI/models/LLM

# was-node-suite-comfyui
cd /ComfyUI/custom_nodes && \
git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && \
cd was-node-suite-comfyui && \
pip3 install -r requirements.txt

# ComfyUI-Logic
cd /ComfyUI/custom_nodes && \
git clone https://github.com/theUpsider/ComfyUI-Logic.git

# ComfyUI_essentials
cd /ComfyUI/custom_nodes && \
git clone https://github.com/cubiq/ComfyUI_essentials.git && \
cd ComfyUI_essentials && \
pip3 install -r requirements.txt

# cg-image-picker
cd /ComfyUI/custom_nodes && \
git clone https://github.com/chrisgoringe/cg-image-picker.git

# ComfyUI_LayerStyle
# pip install inference-cli==0.17.0
# cd /ComfyUI/custom_nodes && \
#     git clone https://github.com/chflame163/ComfyUI_LayerStyle.git && \
#     cd ComfyUI_LayerStyle && \
#     pip3 install -r requirements.txt

# comfyui-reactor-node
cd /ComfyUI/custom_nodes && \
git clone https://github.com/Gourieff/comfyui-reactor-node.git && \
cd comfyui-reactor-node && \
pip3 install -r requirements.txt

# cg-use-everywhere
cd /ComfyUI/custom_nodes && \
git clone https://github.com/chrisgoringe/cg-use-everywhere.git

# ComfyUI-CogVideoXWrapper
cd /ComfyUI/custom_nodes && \
git clone https://github.com/kijai/ComfyUI-CogVideoXWrapper.git && \
cd ComfyUI-CogVideoXWrapper && \
pip3 install -r requirements.txt

# ComfyUI-Detail-Daemon
cd /ComfyUI/custom_nodes && \
git clone https://github.com/Jonseed/ComfyUI-Detail-Daemon && \
cd ComfyUI-Detail-Daemon && \
pip3 install -r requirements.txt 

# GGUF
cd /ComfyUI/custom_nodes && \
git clone https://github.com/city96/ComfyUI-GGUF && \
cd ComfyUI-GGUF && \
pip3 install -r requirements.txt

# PuLID-Flux-Enhanced
cd /ComfyUI/custom_nodes && \
git clone https://github.com/sipie800/ComfyUI-PuLID-Flux-Enhanced && \
cd PuLID-Flux-Enhanced && \
pip3 install -r requirements.txt

# ComfyUI_AdvancedRefluxControl
cd /ComfyUI/custom_nodes && \
git clone https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl && \
cd ComfyUI_AdvancedRefluxControl && \
pip3 install -r requirements.txt

# Comfyui_Flux_Style_Adjust
cd /ComfyUI/custom_nodes && \
git clone https://github.com/yichengup/Comfyui_Flux_Style_Adjust 

# Comfyui_TTP_Toolset
cd /ComfyUI/custom_nodes && \
git clone https://github.com/TTPlanetPig/Comfyui_TTP_Toolset
# Some custom nodes need this env variable
COMFYUI_PATH=/ComfyUI

# ComfyUI-Manager
cd /ComfyUI/custom_nodes && \
git clone https://github.com/ltdrdata/ComfyUI-Manager && \
cd ComfyUI-Manager && \
pip3 install -r requirements.txt

# ComfyUI-Custom-Scripts
cd /ComfyUI/custom_nodes && \
git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts && \
cd ComfyUI-Custom-Scripts && \
pip3 install -r requirements.txt

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
git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack impact_subpack && \
pip3 install -r requirements.txt && \
python3 install-manual.py

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
cd /ComfyUI/custom_nodes && \
git clone https://github.com/chflame163/ComfyUI_LayerStyle.git && \
cd ComfyUI_LayerStyle && \
pip3 install -r requirements.txt

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

# ComfyMath
cd /ComfyUI/custom_nodes && \
git clone https://github.com/evanspearman/ComfyMath && \
cd ComfyMath && \
pip3 install -r requirements.txt

# ComfyUI-AdvancedLivePortrait
cd /ComfyUI/custom_nodes && \
git clone https://github.com/PowerHouseMan/ComfyUI-AdvancedLivePortrait && \
cd ComfyUI-AdvancedLivePortrait && \
pip3 install -r requirements.txt

# ComfyUI-BiRefNet-Hugo
# downoad the model https://huggingface.co/ZhengPeng7/BiRefNet/tree/main 
cd /ComfyUI/custom_nodes && \
git clone https://github.com/MoonHugo/ComfyUI-BiRefNet-Hugo && \
cd ComfyUI-BiRefNet-Hugo && \
pip3 install -r requirements.txt && \
mkdir -p /workspace/models/rembg && \
cd /workspace/models/rembg && \
pget https://huggingface.co/ZhengPeng7/BiRefNet/resolve/main/model.safetensors ./BiRefNet.safetensors


# ComfyUI-SAM2
cd /ComfyUI/custom_nodes && \
git clone https://github.com/neverbiasu/ComfyUI-SAM2 && \
cd ComfyUI-SAM2 && \
pip3 install -r requirements.txt

# ComfyUI_IPAdapter_plus
cd /ComfyUI/custom_nodes && \
git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus

# ComfyUI_Mira
cd /ComfyUI/custom_nodes && \
git clone https://github.com/mirabarukaso/ComfyUI_Mira 

# Comfyui-In-Context-Lora-Utils
cd /ComfyUI/custom_nodes && \
git clone https://github.com/lrzjason/Comfyui-In-Context-Lora-Utils

# Comfyui_JC2
cd /ComfyUI/custom_nodes && \
git clone https://github.com/TTPlanetPig/Comfyui_JC2 && \
cd Comfyui_JC2 && \
pip3 install -r requirements.txt

#  Comfyui_Object_Migration
cd /ComfyUI/custom_nodes && \
git clone https://github.com/TTPlanetPig/Comfyui_Object_Migration 

# ComfyUI-Image-Saver
cd /ComfyUI/custom_nodes && \
git clone https://github.com/farizrifqi/ComfyUI-Image-Saver && \
cd ComfyUI-Image-Saver && \
pip3 install -r requirements.txt

# comfyui-art-venture
cd /ComfyUI/custom_nodes && \
git clone https://github.com/sipherxyz/comfyui-art-venture && \
cd comfyui-art-venture && \
pip3 install -r requirements.txt

# comfyui-mixlab-nodes
cd /ComfyUI/custom_nodes && \
git clone https://github.com/shadowcz007/comfyui-mixlab-nodes && \
cd comfyui-mixlab-nodes && \
pip3 install -r requirements.txt

#  comfyui-tensorops
cd /ComfyUI/custom_nodes && \
git clone https://github.com/un-seen/comfyui-tensorops && \
cd comfyui-tensorops && \
pip3 install -r requirements.txt

# comfyui-various
cd /ComfyUI/custom_nodes && \
git clone https://github.com/jamesWalker55/comfyui-various
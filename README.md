# Swiss knife to create workflows with ComfyUI and Train models with Ostris Ai Toolkit
This is a fork of [ComfyUI_with_Flux](https://github.com/ValyrianTech/ComfyUI_with_Flux)

# Improvements: 

## Models folder into /workspace/models
Soft linked the folders ***/workspace/models*** that can be synced with Google Cloud Storage, AWS or any other available on Runpod.  

The deployment is faster and keeps weights safe in external network storage. 

## Api 
A simple example is available into API folder
```
python api_example.py --ip 194.68.245.38 --port 22018 --filepath workflow_api_format.json
```
Optionally, you can also specify a new prompt for the workflow:
```
python api_example.py --ip 194.68.245.38 --port 22018 --filepath workflow_api_format.json --prompt "platinum blonde woman with magenta eyes"
```

## Push on Docker Hub
```
sh push-to-docker-hub.sh
```
[Link to Docker Hub](https://hub.docker.com/repository/docker/alexgenovese/runpod-pod-comfyui/general)

### Credits
[ComfyUI_with_Flux](https://github.com/ValyrianTech/ComfyUI_with_Flux)

# 🚀 text2video-wan2.1-fusionx

**Text2Video workflow powered by [ComfyUI](https://github.com/comfyanonymous/ComfyUI), Wan2.1 14B FusionX LoRA, UMT5 encoder, and FP8 VAE.**  
Generate high-quality videos from text prompts with reproducible results, custom nodes, and a Docker-ready setup.

---

## ✨ Features

- **ComfyUI Integration**: Automated setup and updates via PowerShell scripts.
- **Wan2.1 14B FusionX LoRA**: Advanced LoRA for text-to-video generation.
- **UMT5 Encoder & FP8 VAE**: Enhanced encoding and video quality.
- **Custom Nodes**: Extend ComfyUI with [VideoHelperSuite](https://github.com/pfrancug/ComfyUI-VideoHelperSuite) and [WanVideoWrapper](https://github.com/pfrancug/ComfyUI-WanVideoWrapper).
- **Docker Support**: GPU/CPU containers for easy deployment.
- **Model Management**: Scripts to download and organize models.

---

## 🗂️ Project Structure

```
📁 docker/
│   ├── comfy.docker-compose.yml        # Docker Compose for ComfyUI
│   ├── comfy.dockerfile                # Dockerfile for ComfyUI
│   ├── cuda.docker-compose.yml         # Docker Compose for CUDA
│   └── cuda.dockerfile                 # Dockerfile for CUDA
📁 powershell/
│   ├── cuda-build.ps1                  # Build CUDA base image
│   ├── comfy-run.ps1                   # Start/stop/rebuild ComfyUI Docker
│   ├── prepare-comfy.ps1               # Download & setup ComfyUI
│   ├── prepare-video_helper_suite.ps1  # Setup VideoHelperSuite node
│   └── prepare-wan_video_wrapper.ps1   # Setup WanVideoWrapper node
📁 tools/
│   └── overrides/                      # Directory for custom nodes, models, packages, and user configs
```

---

## ⚡ Quickstart

### 1. **Clone the Repository**

```sh
git clone https://github.com/pfrancug/text2video-wan2.1-fusionx.git
cd text2video-wan2.1-fusionx
```

### 2. **Prepare ComfyUI & Custom Nodes**

Run the PowerShell scripts (Windows):

```sh
powershell\prepare-comfy.ps1
powershell\prepare-video_helper_suite.ps1
powershell\prepare-wan_video_wrapper.ps1
```

### 3. **Start with Docker**

```sh
powershell\cuda-build.ps1
powershell\comfy-run.ps1
```

---

## 📦 Dependencies

This workflow relies on the following software and resources:

- **[ComfyUI](https://github.com/comfyanonymous/ComfyUI)** – the main framework for building text-to-video pipelines.  
- **Custom nodes used in this workflow:**  
  - [VideoHelperSuite (fork)](https://github.com/pfrancug/ComfyUI-VideoHelperSuite) – originally by [Kosinkadink](https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite)  
  - [WanVideoWrapper (fork)](https://github.com/pfrancug/ComfyUI-WanVideoWrapper) – originally by [kijai](https://github.com/kijai/ComfyUI-WanVideoWrapper)  
- **Python packages** – see [`tools/overrides/packages.txt`](tools/overrides/packages.txt) for required dependencies.


---

## 📝 License

MIT License © 2025 Piotr Francug  
See [`LICENSE`](LICENSE) for details.

---

## 💡 Tips

- For latest ComfyUI, run `powershell\prepare-comfy.ps1 --latest`
- Use `powershell\comfy-run.ps1` to rebuild and restart containers safely.
- All scripts run relative to their own directory for reliability.

---

## 🛠️ Roadmap / TODO

- Implement automated model downloads with curl.
- Adjust workflow JSON files for reproducibility.
- Create a main `prepare.ps1` script to orchestrate all setup tasks.
- Transform all PowerShell scripts into cross-platform `.sh` versions.
- Validate full setup from environment preparation to video generation.

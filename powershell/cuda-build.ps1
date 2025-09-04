# --------------------------
# Always run relative to this script's directory
# --------------------------
Set-Location $PSScriptRoot

# --------------------------
# Specify which Dockerfile to use for CUDA build
# --------------------------
$dockerfile = "../docker/cuda.dockerfile"
$imageName = "cuda-python:13.0-py3.11"

# --------------------------
# Build the CUDA Python base image
# --------------------------
Write-Host "Building CUDA Python base image..."
docker build -f $dockerfile -t $imageName ..

# --------------------------
# Script complete
# --------------------------
Write-Host "CUDA base image build complete."

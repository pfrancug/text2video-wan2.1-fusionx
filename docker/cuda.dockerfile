# --------------------------
# Base image: CUDA runtime with cuDNN on Ubuntu 22.04
# --------------------------
FROM nvidia/cuda:13.0.0-cudnn-runtime-ubuntu22.04

# --------------------------
# Set environment variables for non-interactive installs and unbuffered Python output
# --------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# --------------------------
# Install system dependencies and essential tools
# --------------------------
RUN apt-get update && apt-get install -y \
    software-properties-common wget build-essential \
    libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev \
    libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev \
    libbz2-dev libexpat1-dev liblzma-dev tk-dev libffi-dev uuid-dev \
    ffmpeg git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# --------------------------
# Add deadsnakes PPA and install Python 3.11 and related packages
# --------------------------
RUN add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y \
       python3.11 python3.11-venv python3.11-distutils \
    && rm -rf /var/lib/apt/lists/*

# --------------------------
# Set python3 to point to Python 3.11
# --------------------------
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# --------------------------
# Install pip for Python 3.11 and upgrade to the latest version
# --------------------------
RUN wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && python3 -m pip install --no-cache-dir --upgrade pip

# --------------------------
# Set working directory for dependent applications
# --------------------------
WORKDIR /app

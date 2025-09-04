# --------------------------
# Use your prebuilt CUDA + Python image
# --------------------------
FROM cuda-python:13.0-py3.11

# --------------------------
# Set environment variables for non-interactive installs and unbuffered Python output
# --------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# --------------------------
# Set working directory for ComfyUI
# --------------------------
WORKDIR /app/ComfyUI

# --------------------------
# Copy requirements files first to leverage Docker cache for dependencies
# --------------------------
COPY tools/ComfyUI/requirements.txt .

# --------------------------
# Install Python dependencies
# --------------------------
RUN python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir -r requirements.txt

# --------------------------
# Copy the main ComfyUI source code
# --------------------------
COPY tools/ComfyUI .

# --------------------------
# Expose the default ComfyUI port
# --------------------------
EXPOSE 8188

# --------------------------
# Start ComfyUI server
# --------------------------
CMD ["python3", "main.py", "--listen", "0.0.0.0"]
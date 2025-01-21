# Use Python as the base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the local Keras repository into the container
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install -e .

# Command to verify Keras installation
CMD ["python3", "-c", "import keras; print(f'Keras version: {keras.__version__}')"]

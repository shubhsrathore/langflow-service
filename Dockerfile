# Use official slim image with Python 3.10
FROM python:3.10-slim

# Avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive
ENV LANGFLOW_DEBUG=true

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        libffi-dev \
        python3-dev \
        procps \
        curl \
        && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python packages
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Optional: Copy your Langflow config or source files if any
# COPY . .

# Expose default Langflow port
EXPOSE 7860

# Monitor memory usage and start Langflow
CMD bash -c "\
    echo 'Starting memory monitor...' && \
    ( while true; do \
        echo '[MEM]'; \
        ps -o pid,vsz,rss,comm -p $$; \
        sleep 10; \
      done ) & \
    echo 'Starting Langflow...' && \
    langflow run --host 0.0.0.0 --port 7860 || \
    echo 'Langflow crashed. Check memory usage or logs.'"

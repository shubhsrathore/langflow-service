FROM python:3.10-slim

# Install OS packages for building native extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       build-essential \
       gcc \
       libffi-dev \
       python3-dev \
       curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose port used by Langflow
EXPOSE 7860

# Start Langflow on container start
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]

# Use a base image with Python
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirement files
COPY requirements.txt .
COPY constraints.txt .

# Install Python dependencies with constraint
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt --constraint constraints.txt

# Copy your FastAPI and Langflow app code
COPY . .

# Expose the port FastAPI/Langflow will run on
EXPOSE 7860

# Start Langflow with FastAPI
CMD ["langflow", "run"]

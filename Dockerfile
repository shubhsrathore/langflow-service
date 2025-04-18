FROM python:3.10-slim

# Give pip more time and disable cache
ENV PIP_NO_CACHE_DIR=1 \
    PIP_DEFAULT_TIMEOUT=100

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy your Langflow code
COPY . .

# Expose the port Langflow uses
EXPOSE 7860

# Start Langflow when the container launches
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]

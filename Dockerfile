FROM python:3.10-slim

# Give pip more time, more retries, no cache, and use the simple index
ENV PIP_NO_CACHE_DIR=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_RETRIES=5 \
    PIP_INDEX_URL=https://pypi.org/simple

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .

# 1. Upgrade pip itself
RUN pip install --upgrade pip \
    && \
# 2. Install with our enhanced settings
    pip install -r requirements.txt

# Copy your Langflow code
COPY . .

EXPOSE 7860
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]

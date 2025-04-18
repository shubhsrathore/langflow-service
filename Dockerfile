FROM python:3.10-slim

# 1) Install OS packages for building native extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       build-essential \
       gcc \
       libffi-dev \
       python3-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2) Copy your minimal requirements.txt
COPY requirements.txt .

# 3) Install langflow and its deps (including caio)
RUN pip install --no-cache-dir -r requirements.txt

# 4) Expose and launch
EXPOSE 7860
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]

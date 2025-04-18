# Use a slim base image for smaller builds
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy in your pinned dependencies
COPY requirements.txt .

# Install exactly what you need (no backtracking)
RUN pip install --no-cache-dir -r requirements.txt

# Copy your Langflow flows (if you’re bundling them), otherwise the server starts clean
# COPY flows/ ./flows/

# Expose the port Langflow listens on
EXPOSE 7860

# Run Langflow in API‑only mode
CMD ["langflow", "run", "--api", "--host", "0.0.0.0", "--port", "7860"]

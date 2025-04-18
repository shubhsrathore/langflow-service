FROM python:3.10-slim

WORKDIR /app
COPY requirements.txt .

# Install exactly langflow and its pinned deps
RUN pip install --no-cache-dir -r requirements.txt

# (Optional) If you’re bundling flows, copy them in:
# COPY flows/ ./flows/

EXPOSE 7860

CMD ["langflow", "run", "--api", "--host", "0.0.0.0", "--port", "7860"]

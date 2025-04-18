FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 7860
CMD ["langflow", "run", "--api", "--host", "0.0.0.0", "--port", "7860"]

FROM python:3.10

# Install Langflow
RUN pip install langflow

# Expose the port
EXPOSE 7860

# Run in API-only mode
CMD ["langflow", "run", "--api", "--host", "0.0.0.0", "--port", "7860"]

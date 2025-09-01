# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /data

# Install system dependencies (for psycopg2, Pillow, etc. if needed)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       python3-dev \
       libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Default command (can override in docker-compose or k8s)
CMD ["gunicorn", "todoApp.wsgi:application", "--bind", "0.0.0.0:8000"]


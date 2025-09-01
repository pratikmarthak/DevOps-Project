FROM python:3.11-slim

# Set working directory
WORKDIR /data

# Install system dependencies (distutils, venv, etc.)
RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-venv \
 && rm -rf /var/lib/apt/lists/*

# Copy requirements first (better for caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project
COPY . .

# Expose port
EXPOSE 8000

# Start Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

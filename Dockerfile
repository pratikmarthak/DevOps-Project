# Use a stable Python version compatible with Django 3.2
FROM python:3.10-slim

# Set working directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-distutils python3-apt build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Run the app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


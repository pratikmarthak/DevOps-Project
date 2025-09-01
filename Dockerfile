# Use Python 3.12 (not 3.13, since Django 4.2 is stable on 3.12)
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-venv \
    python3-distutils \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt first (for Docker cache efficiency)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Expose Django port
EXPOSE 8000

# Run migrations and start the app with Gunicorn
CMD ["sh", "-c", "python manage.py migrate && gunicorn todoApp.wsgi:application --bind 0.0.0.0:8000"]

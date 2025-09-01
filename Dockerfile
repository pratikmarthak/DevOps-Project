# Use Python 3.11 slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3.11-distutils \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Copy requirements if you have them
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy project
COPY . .

# Run migrations (optional: you can also run this in entrypoint.sh)
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Command to run the app with gunicorn
CMD ["gunicorn", "todo.wsgi:application", "--bind", "0.0.0.0:8000"]

# Use Python 3.11 (not 3.13)
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies + distutils
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3.11-distutils \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Copy requirements first
COPY requirements.txt .

# Install python dependencies
RUN pip install -r requirements.txt

# Copy project
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Run server with gunicorn
CMD ["gunicorn", "todo.wsgi:application", "--bind", "0.0.0.0:8000"]

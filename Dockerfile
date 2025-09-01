# Use Python 3.11 to avoid the distutils removal in 3.12/3.13
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# (Optional) system deps if any wheels need compiling
RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project
COPY . .

EXPOSE 8000

# Run migrations at container start, then launch Gunicorn
CMD ["sh","-c","python manage.py migrate --noinput && gunicorn todoApp.wsgi:application --bind 0.0.0.0:8000"]

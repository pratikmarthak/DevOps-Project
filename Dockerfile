# Instead of "python:3"
FROM python:3.11-slim

WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y python3-distutils && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "todo_project.wsgi:application"]

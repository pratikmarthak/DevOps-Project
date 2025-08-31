FROM python:3

WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y python3-distutils

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy project files
COPY . .

EXPOSE 8000

# Default command to run app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

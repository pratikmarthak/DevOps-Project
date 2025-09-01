# Use Python 3.11 (compatible with Django 3.2)
FROM python:3.11

# Set working directory
WORKDIR /data

# Copy requirements and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose port 8000
EXPOSE 8000

# Run the app (migrations should be done after container starts)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM python:3.11   # safer version for Django 3.2

WORKDIR /data

# Install dependencies
RUN apt-get update && apt-get install -y python3-distutils

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Do not run migrate at build time
# CMD will handle it when container runs
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

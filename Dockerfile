FROM python:3

WORKDIR /data

RUN pip install django==3.2

COPY . .

# RUN python manage.py migrate

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]



sudo docker build . -t todo-app
sudo docker run -p 8000:8000 -d todo-app

# FROM python:3

# WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y python3-distutils

# Install Django and dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy project files
# COPY . .

# EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


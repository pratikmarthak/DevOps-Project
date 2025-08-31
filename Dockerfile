FROM python:3

WORKDIR /data

RUN pip install django==3.2

COPY . .

RUN python manage.py migrate

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]



sudo docker build . -t todo-app
sudo docker run -p 8000:8000 -d todo-app

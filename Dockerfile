
FROM python:3.6

WORKDIR /usr/src/

RUN git clone git://github.com/gpodder/mygpo.git

RUN apt-get install libpq-dev libjpeg-dev zlib1g-dev libwebp-dev libffi-dev

WORKDIR /usr/src/mygpo 

RUN pip install -r requirements.txt

VOLUME /usr/src/mygpo

EXPOSE 8000

CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]

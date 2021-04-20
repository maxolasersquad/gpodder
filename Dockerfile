FROM python:3.8-alpine as base

FROM base as builder

WORKDIR /usr/src/

RUN apk update && apk add git postgresql-dev gcc python3-dev musl-dev libffi-dev zlib-dev jpeg-dev

RUN git clone git://github.com/gpodder/mygpo.git

WORKDIR /usr/src/mygpo 

RUN pip install -r requirements.txt --prefix=/install

FROM base

COPY --from=builder /usr/src/mygpo /usr/src/mygpo

COPY --from=builder /install /usr/local

WORKDIR /usr/src/mygpo 

RUN apk update && apk add libpq libwebp libjpeg

EXPOSE 8000

RUN pip install gunicorn celery django-celery-beat

CMD [ "gunicorn", "-b", ":8000", "mygpo.wsgi" ]

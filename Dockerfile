FROM python:3.9.16-slim

RUN apt-get update && \
    apt-get install -y gcc git libpq-dev libmagic1 && \
    apt clean && \
    rm -rf /var/cache/apt/*

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PYTHONIOENCODING utf-8

COPY requirements/ /tmp/requirements

#================================================
# Packages
#================================================
RUN pip install --upgrade pip && pip install wheel &&\
    pip install --no-cache-dir -r /tmp/requirements/base.txt


#================================================
# Code
#================================================
COPY . /code
RUN useradd -m -d /code -s /bin/bash app \
    && chown -R app:app /code/*
WORKDIR /code/src
USER app
CMD ["uvicorn", "app.main:app", "--reload", "--host=0.0.0.0"]

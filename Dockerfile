FROM python:3.9.16-slim

RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list &&\
    rm -Rf /var/lib/apt/lists/* &&\
    apt-get update

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

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
WORKDIR /code/src
CMD ["uvicorn", "app.main:app", "--reload", "--host=0.0.0.0"]

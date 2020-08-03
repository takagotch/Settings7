### Setting7
---



```docker-compose.yml
version: '3'
services:
  db:
    image: postgres:11.2-alpine
    volumes:
     - ./tmp/db:/var/lib/postgresql/data
  web:
    build: .
    command: /bin/sh
    environment:
      WEBPACKER_DEV_SERVER_HOST: "0.0.0.0"
      RAILS_SERVE_STATICFILES: "1"
      EDITOR: "vim"
    volumes:
     - ./apps:/apps
    ports:
     - "3000:3000"
     - "3035:3035"
    depends_on:
     - db
    tty: true
```

```Dockerfile
FROM takagotch/settings:latest

ARG UID=1000
ARG GID=1000

RUN
RUN
RUN
RUN

WORKDIR
COPY
COPY
RUN

USER

RUN
RUN echo $'export SECRET_KEY_BASE=$(cat /home/devel/.secret_key_base)' \
  >> /home/devel/.bashrc

WORKDIR /app
```



```
```


---

https://github.com/alpinelinux/docker-alpine

https://hub.docker.com/_/alpine?ref=login

- alpine3.9
- ruby:2.7.1
- postgersql 11.1
- node.js 10.14.2
- yarn 1.12.3
- gem 3.0.1
- bundler 1.17.2
- vim
- git
- openssh

```Dockerfile
FROM ruby:2.7.1-alpine3.9

RUN apk update
RUN apk upgrade

RUN apk add --no-cache \
   bash git vim openssh openssl yarn sudo su-exec shadow tzdata \
   postgresql-client postgresql-dev \
   build-base libxml2-dev libxslt-dev
```

```
# build
docker build -t takagotch/settings7 .
# start
docker run -itd --name settings7 takagotch/settings:latest
# login
docker ps
docker ps -a
docker exec -it --user devel settings7 bash
# destroy
docker stop settings7
docker rm settings7

# refresh
docker stop settings7
docker rm settings7
docker build -t takagotch/settings7 .
docker run -itd --name settings7 takagotch/settings7:latest
docker exec -it settings7 bash

```


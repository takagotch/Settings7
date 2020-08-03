### Setting7
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

```
```



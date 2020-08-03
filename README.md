### Setting7
---

https://github.com/alpinelinux/docker-alpine

https://hub.docker.com/_/alpine?ref=login


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
```

```
```



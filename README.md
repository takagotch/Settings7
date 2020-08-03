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

RUN mkdir /var/mail
RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /tmp
COPY init/Gemfile /tmp/Gemfile
COPY init/Gemfile.lock /tmp/Gemfile.lock
RUN  bundle install

COPY ./apps /apps

RUN apk add --no-cache openssl

USER devel

RUN openssl rand -hex 64 > /home/devel/.secret_key_base
RUN echo $'export SECRET_KEY_BASE=$(cat /home/devel/.secret_key_base)' \
  >> /home/devel/.bashrc

WORKDIR /app
```
```sh

cd apptky
rails new apptky -BJS -d posgresql

docker run -it alpine bin/sh
exit

vi Gemfile
<%#
gem 'bootsnap', '>= 1.1.0', require: false
+ gem 'webpacker'
- gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
%>

vi config/database.yml
<!--
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

+ host: db
+ username: postgres
+ password:
-->

cd /apps/myapp
bundle
rails webpacker:install
rails db:create

mkdir app/javascript/stylesheets
cp app/assets/stylesheets/scaffold.css app/javascript/stylesheets
rm -rf app/assets

vi app/javascript/packs/application.js
+ import "../stylesheets/scaffold.css";

vi app/javascript/packs/application.js
- <%= stylesheet_link_tag 'application', media: 'all' %>
+ <%= stylesheet_pack_tag 'application', media: 'all' %>

rails g scaffold user name:string
rails db:migrate

cd /app/apptky
bin/webpack-dev-server

cd /apps/apptky
rails s

rails db:rollback
rails d scaffold user

docker-compose stop


docker-compose up -d
docker rm xxxxx
docker-compose up -d --no-recreate
```

###### cmd.sh

```
git clone https://github.com/takagotch/setting7.git
cd settings7

./setup.sh
docker-compose up -d
docker-compose exec web bash
docker-compose stop
docker-compose down
```

```sh
#!/bin/bash
set -eu

docker pull takagotch/docker:latest

BUILD_CMD="docker-compose build --no-cache"

case "$OSTYPE" in
  darwin*)
    $BUILD_CMD web
    ;;
  linux*)
    $BUILD_CMD --build-arg UID=$(id -u) --build-arg GID=$(id -g) web
    ;;
  *)
    echo "Unknown OS Type: $OSTYPE"
    ;;
esac
```

###### MIGW64

```sh
git clone https://github.com/takagotch/settings7.git
cd settings7
cd docker-compose.win.yml docker-compose.override.yml

docker volume create --name pgdata

docker pull takagotch/settings7:latest
docker-compose build
docker-compose up -d
docker-compose exec web bash
docker-compose stop
docker-compose down
docker volume rm pgdata

```

```docker-compose.win.yml
version: '3'
services:
  db:
    image: postgres:11.2-alpine
    volumes:
     - data:/var/lib/postgresql/data
  web:
    build: .
    command: /bin/sh
    environment:
      WEBPACKER_DEV_SERVER_HOST: "0.0.0.0"
      RAILS_SERVE_STATIC_FILES: "1"
      EDITOR: "vim"
    volumes:
     - ./apps:/apps
    ports:
     - "3000:3000"
     - "3035:3035"
    depends_on:
     - db
    tty: true
volumes:
  data:
    external:
      name: pgdata
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


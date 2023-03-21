# Step 0: Library Image
# Step 1: Build IIPImage Server, OpenSeadragon from sources
FROM ubuntu:20.04 AS build

ENV IIPSERVER https://github.com/RationAI/iipsrv 
ENV OPENSEADRAGON https://github.com/RationAI/openseadragon.git

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.7.0
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
WORKDIR /usr/app

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \

        # Cloning Deps
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \

        # CPP Tools (Server only) todo remove libpqxx
        g++ \
        autoconf \
        libtool \
        pkg-config \
        libjsoncpp-dev \
        libvips-dev \
        libpqxx-dev \
        cmake \

        --fix-missing \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \

    # Minizip-ng todo proxy repo
RUN mkdir minizip-ng \
    && git clone https://github.com/zlib-ng/minizip-ng.git minizip-ng \
    && cd minizip-ng \
    && cmake -S . -B build -DMZ_COMPRESS_ONLY=ON -DMZ_BZIP2=OFF -DMZ_LZMA=OFF -DMZ_ZSTD=OFF -DMZ_LIBCOMP=OFF -DMZ_FETCH_LIBS=ON -DMZ_ZLIB=OFF -DMZ_OPENSSL=OFF \
    && cmake --build build \
    && cp build/libminizip.a libminizip-ng.a \
    && cd .. \

    # Build Image Server File: /usr/app/server/src/iipsrv.fcgi
    && mkdir server && cd server \
    && git clone $IIPSERVER . \
    && ./autogen.sh \
    && ./configure \
       CXXFLAGS="$(pkg-config vips-cpp jsoncpp libpqxx --cflags)" \
       LIBS="$(pkg-config vips-cpp jsoncpp libpqxx --libs)" \
       LDFLAGS="-L../../minizip-ng" \
       CPPFLAGS="-I../../minizip-ng" \
    && make \
    && cd .. \

    # Install NVM https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
    && rm /bin/sh && ln -s /bin/bash /bin/sh \
    && mkdir $NVM_DIR \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    # Build OSD: /usr/app/osd/build/openseadragon/openseadragon.js
    && mkdir osd && cd osd \
    && git clone $OPENSEADRAGON . \
    && npm install -g grunt-cli \
    && npm install \
    && grunt build \
    && cd .. 

# Step 2: Run Docker. Do not use debian-based images: libjpeg8 not available!
FROM ubuntu:jammy AS viewer

ENV BROWSER https://github.com/RationAI/browser.git
ENV VIEWER https://github.com/RationAI/xopat.git
ENV DB_PROXY https://github.com/RationAI/xo_db

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y \
        # Cloning Deps
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        # HTTP Server
        apache2 \
        # PHP Apps
        libapache2-mod-php \
        php-cli \
        php-curl \
        php-mbstring \
        php-json \
        php-mime-type \
        php-pgsql \
        # FCGI Server + .so libs
        libapache2-mod-fcgid \
        libtiff-dev \
        libjpeg-dev \
        libvips \
        memcached \

        --fix-missing \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite headers expires ext_filter

WORKDIR /usr/app

# Server-related files that are better to copy before changing access rights etc.
COPY ports.conf .
COPY server/apache.conf server-apache.conf
COPY client/apache.conf /etc/apache2/sites-available/000-default.conf
COPY --from=build /usr/app/server/src/iipsrv.fcgi /var/www/localhost/fcgi-bin/
COPY client/index.php /var/www/html/index.php

    # General
RUN cat /usr/app/ports.conf >> /etc/apache2/ports.conf \
    && phpenmod pdo_pgsql \
    && a2enmod proxy && a2enmod proxy_http \
    # IIPServer
    && touch /var/log/iipsrv.log \
    && chmod 666 /var/log/iipsrv.log \
    && cat /usr/app/server-apache.conf >> /etc/apache2/sites-available/000-default.conf \
    && chown www-data:www-data /var/www/localhost/fcgi-bin/iipsrv.fcgi \
    && chmod a+x /var/www/localhost/fcgi-bin/iipsrv.fcgi \
    # Client
    && mkdir /var/www/html/browser && git clone $BROWSER /var/www/html/browser \
    && mkdir /var/www/html/xopat && git clone  $VIEWER /var/www/html/xopat \
    # for dev branch: 
    # && cd /var/www/html/xopat && git checkout development && cd /usr/app \
    && mkdir /var/www/html/xo_db && git clone $DB_PROXY /var/www/html/xo_db \
    && mkdir -p /var/www/html/xopat/openseadragon/build/openseadragon \
    && mkdir -p /var/www/data \
    && chown -R www-data:www-data /var/lock /var/log /var/www /var/run /run/lock /var/www/data \
    && chmod --recursive 777 /var/run /var/www/data 

# Overwrites / extends on files cloned, needs to run after git clone
COPY client/browser/config.php /var/www/html/browser/config.php
COPY client/xopat/env.json /var/www/html/xopat/env/env.json
COPY --from=build /usr/app/osd/build/openseadragon/*.js /var/www/html/xopat/openseadragon/build/openseadragon/
COPY --from=build /usr/app/osd/build/openseadragon/*.map /var/www/html/xopat/openseadragon/build/openseadragon/

EXPOSE 8080-9000
CMD ["systemctl", "start", "memcached"]
CMD ["system","apache2","reload"]
CMD ["apache2ctl","-D","FOREGROUND"]
USER www-data

# Do not use debian-based images: libjpeg8 not available!
FROM ubuntu:jammy AS importer

ENV IMPORTER https://github.com/RationAI/mirax-importer
ENV DB_PROXY https://github.com/RationAI/xo_db

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install --no-install-recommends --fix-missing -y \
        # Cloning Deps
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        libvips-tools \
        python3-dev \
        python3-pip \
        gcc \
        tini \
        vim \
        nano \
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
    && apt clean \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /usr/app

# Todo problem if php version upgrades in image, the version installed is 8.1 and path will change :/
COPY php.ini /etc/php/8.1/apache2/conf.d/uploads.ini

    # General
RUN pip install kubernetes randomname pyyaml openslide-python \
    && phpenmod pdo_pgsql \
    # Auth: enable modules, prepare files/dirs
    && a2enmod rewrite headers expires ext_filter env dir \
    && touch /etc/apache2/.env.apache \
    && mkdir -p /usr/local/etc/apache \
    # Client
    && mkdir /var/www/html/xo_db && git clone $DB_PROXY /var/www/html/xo_db \
    && mkdir /var/www/html/importer && git clone $IMPORTER /var/www/html/importer \
    && mkdir -p /var/www/data \
    && chown -R www-data:www-data /var/lock /var/log /var/www /var/run /run/lock /etc/apache2/.env.apache \
    && chmod --recursive 777 /var/run /var/www/data /var/www/html/importer/server

COPY --chown=www-data:www-data apache.conf /etc/apache2/sites-available/000-default.conf
COPY --chown=www-data:www-data config.php /var/www/html/importer/server/config.php
COPY --chown=www-data:www-data xo_config.php /var/www/html/xo_db/config.php
COPY --chown=www-data:www-data index.php /var/www/html/index.php
COPY --chown=www-data:www-data docker-entrypoint.sh /var/www/docker-entrypoint.sh
# Our internal use-case: health url that returns 200
COPY --chown=www-data:www-data .htaccess /var/www/html/.htaccess
COPY --chown=www-data:www-data health /var/www/html/health

EXPOSE 8081

USER www-data

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD /var/www/docker-entrypoint.sh

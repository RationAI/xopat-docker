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
        tini \
        bzip2 \
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

# Micromamba does not work with 'sh'
SHELL ["/bin/bash", "-c"]

    # General
RUN wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xjv bin/micromamba  \
    && mv bin/micromamba /usr/bin/micromamba && rm -r bin \
    && touch /root/.bashrc \
    && micromamba shell init -s bash -p /var/www/micromamba  \
    #problems on ubuntu
    && grep -v '[ -z "\$PS1" ] && return' /root/.bashrc > /var/www/.bashrc \
    && phpenmod pdo_pgsql \
    # Auth: enable modules, prepare files/dirs
    && a2enmod rewrite headers expires ext_filter env dir \
    && touch /etc/apache2/.env.apache && mkdir -p /usr/local/etc/apache/ && touch /usr/local/etc/apache/.htpasswd \
    # Client
    && mkdir /var/www/html/xo_db && git clone $DB_PROXY /var/www/html/xo_db \
    && mkdir /var/www/html/importer && git clone $IMPORTER /var/www/html/importer \
    && mkdir -p /var/www/data \
    && chown -R www-data:www-data /var/lock /var/log /var/www /var/run /run/lock /usr/local/etc/apache/.htpasswd /etc/apache2/.env.apache \
    && chmod --recursive 777 /var/run /var/www/data /var/www/html/importer/server

COPY apache.conf /etc/apache2/sites-available/000-default.conf
COPY config.php /var/www/html/importer/server/config.php
COPY xo_config.php /var/www/html/xo_db/config.php
COPY index.php /var/www/html/index.php
COPY docker-entrypoint.sh /var/www/docker-entrypoint.sh
# Our internal use-case: health url that returns 200
COPY .htaccess /var/www/html/.htaccess
COPY health /var/www/html/health

EXPOSE 8081
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD /var/www/docker-entrypoint.sh
USER www-data

RUN micromamba create -n snakemake snakemake -c conda-forge -c bioconda \
    && micromamba create -n mirax_venv python=3.7 openslide-python -c conda-forge

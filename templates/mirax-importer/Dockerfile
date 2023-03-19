# Step 2: Run Docker. Do not use debian-based images: libjpeg8 not available!
FROM ubuntu:jammy AS importer

ENV IMPORTER https://github.com/RationAI/mirax-importer
ENV DB_PROXY https://github.com/RationAI/xo_db

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y \
        # Cloning Deps
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        libvips-tools \
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

        --fix-missing \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite headers expires ext_filter

WORKDIR /usr/app

COPY apache.conf /etc/apache2/sites-available/000-default.conf
# Todo problem if php version upgrades in image, the version installed is 8.1 and path will change :/
COPY php.ini /etc/php/8.1/apache2/conf.d/uploads.ini

    # General
RUN phpenmod pdo_pgsql \
    && a2enmod proxy && a2enmod proxy_http \
    # Client
    && mkdir /var/www/html/importer && git clone $IMPORTER /var/www/html/importer \
    && mkdir /var/www/html/xo_db && git clone $DB_PROXY /var/www/html/xo_db \
    && mkdir -p /var/www/data \
    && chown -R www-data:www-data /var/lock /var/log /var/www /var/run /run/lock /var/www/data \
    && chmod --recursive 777 /var/run /var/www/data /var/www/html/importer/server

EXPOSE 8081
CMD ["system","apache2","reload"]
CMD ["apache2ctl","-D","FOREGROUND"]
USER www-data
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
        tini \
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
        # Mirax Label Extraction:
        python3-pip \

        --fix-missing \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite headers expires ext_filter

WORKDIR /usr/app
ARG XO_BASIC_PWD
ARG XO_BASIC_USER

COPY apache.conf /etc/apache2/sites-available/000-default.conf
# Todo problem if php version upgrades in image, the version installed is 8.1 and path will change :/
COPY php.ini /etc/php/8.1/apache2/conf.d/uploads.ini

    # General
RUN phpenmod pdo_pgsql \
    && pip3 install openslide-python \
    #Auth: if user not set   #just create some file so apache is happy, will not be used              #or make desired auth
    && a2enmod env && mkdir -p /usr/local/etc/apache/ && touch /etc/apache2/.env.apache \
    && [ -z $XO_BASIC_USER ] && (htpasswd -bc /usr/local/etc/apache/.htpasswd 'www-data' '123456789') || (htpasswd -bc /usr/local/etc/apache/.htpasswd $XO_BASIC_USER "$XO_BASIC_PWD" && echo "SetEnv XO_BASIC_AUTH 5" >> /etc/apache2/.env.apache) \
    
    # Client
    && mkdir /var/www/html/xo_db && git clone $DB_PROXY /var/www/html/xo_db \
    && mkdir /var/www/html/importer && git clone $IMPORTER /var/www/html/importer \
    && mkdir -p /var/www/data \
    && chown -R www-data:www-data /var/lock /var/log /var/www /var/run /run/lock /var/www/data \
    && chmod --recursive 777 /var/run /var/www/data /var/www/html/importer/server

COPY config.php /var/www/html/importer/server/config.php
COPY xo_config.php /var/www/html/xo_db/config.php
# Our internal use-case: health url that returns 200
COPY .htaccess /var/www/html/.htaccess
COPY health /var/www/html/health

EXPOSE 8081
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["apache2ctl", "-D", "FOREGROUND"]
USER www-data
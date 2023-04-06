# # Step 1: Miniconda on ubuntu
# FROM ubuntu:jammy AS miniconda-base

# WORKDIR /app

# RUN apt-get update && apt-get install -y wget bzip2 \
#     && wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba \
#     && touch /root/.bashrc \
#     && ./bin/micromamba shell init -s bash -p ~/micromamba  \
#     #problems on ubuntu
#     && grep -v '[ -z "\$PS1" ] && return' /root/.bashrc > /opt/conda/bashrc \
#     && apt-get clean autoremove --yes \
#     && rm -rf /var/lib/{apt,dpkg,cache,log}

# # Step 2: Run Docker. Do not use debian-based images: libjpeg8 not available!
# FROM miniconda-base AS importer

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
        tini \
        gcc \
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

# Micromamba does not work with 'sh'
SHELL ["/bin/bash", "-c"]

    # General
RUN wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xj bin/micromamba  \
    && mv bin/micromamba /usr/bin/micromamba && rm -r bin \
    && touch /root/.bashrc \
    && micromamba shell init -s bash -p /var/www/micromamba  \
    #problems on ubuntu
    && grep -v '[ -z "\$PS1" ] && return' /root/.bashrc > /var/www/.bashrc \
    #&& micromamba create -n mirax_venv python=3.7 snakemake openslide-python -c conda-forge -c bioconda \
    && phpenmod pdo_pgsql \
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
COPY index.php /var/www/html/index.php
# Our internal use-case: health url that returns 200
COPY .htaccess /var/www/html/.htaccess
COPY health /var/www/html/health

EXPOSE 8081
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["apache2ctl", "-D", "FOREGROUND"]
USER www-data

RUN micromamba create -n snakemake snakemake -c conda-forge -c bioconda \
    && micromamba create -n mirax_venv python=3.7 openslide-python -c conda-forge

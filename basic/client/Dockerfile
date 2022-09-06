FROM php:8.0-apache
WORKDIR /var/www/html
COPY . .
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
    && rm -rf /var/lib/apt/lists/*


# Prepare Browser
RUN git clone https://github.com/RationAI/browser.git
COPY ./config/browser/config.php ./browser


# Prepare Pathopus
RUN git clone https://github.com/RationAI/pathopus.git
WORKDIR /var/www/html/pathopus 
RUN git clone https://github.com/RationAI/openseadragon.git 
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV NVM_DIR /usr/local/nvm
RUN mkdir $NVM_DIR
ENV NODE_VERSION 18.7.0
# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN npm install -g grunt-cli
RUN cd openseadragon && npm install && grunt build


# Configure Apache
WORKDIR /var/www/html
RUN chown -R www-data:www-data .
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./ports.conf /etc/apache2/ports.conf
RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN apachectl graceful

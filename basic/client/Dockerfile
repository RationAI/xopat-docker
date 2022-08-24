FROM php:8.0-apache

WORKDIR /var/www/html
COPY . .

#RUN apt-get update
#RUN apt-get install nano

RUN chown -R www-data:www-data .

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./ports.conf /etc/apache2/ports.conf

#RUN echo 'export DOCKER_GATEWAY_HOST=172.17.0.1' >> /etc/environment
#RUN echo '. /etc/environment' >> /etc/apache2/envvars

RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http

RUN apachectl graceful

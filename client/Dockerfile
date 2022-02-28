FROM php:8.0-apache

WORKDIR /var/www/html
COPY . .

#RUN apt-get update
#RUN apt-get install nano

RUN chown -R www-data:www-data .

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN service apache2 restart

# Enable port
EXPOSE 80

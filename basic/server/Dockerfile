FROM ubuntu:20.04
WORKDIR /usr/app/iipsrv

COPY iipsrv /usr/app/iipsrv/
COPY ports.conf /usr/app/
COPY iipimage_conf.conf /usr/app/
COPY create_tables.sql /usr/app/
COPY iipimage_entrypoint.sh /usr/app/

RUN chmod 644 /usr/app/create_tables.sql
RUN chmod 755 /usr/app/iipimage_entrypoint.sh

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y g++ autoconf libtool pkg-config libjsoncpp-dev libvips-dev libpqxx-dev apache2 libapache2-mod-fcgid postgresql
RUN ./autogen.sh
RUN ./configure CXXFLAGS="$(pkg-config vips-cpp jsoncpp libpqxx --cflags)" LIBS="$(pkg-config vips-cpp jsoncpp libpqxx --libs)"
RUN make
RUN mkdir /var/www/localhost && mkdir /var/www/localhost/fcgi-bin
RUN cp src/iipsrv.fcgi /var/www/localhost/fcgi-bin
RUN cat /usr/app/iipimage_conf.conf >> /etc/apache2/apache2.conf
RUN cat /usr/app/ports.conf >> /etc/apache2/ports.conf
USER postgres
RUN service postgresql start && psql -f ../create_tables.sql
USER root
ENTRYPOINT ["../iipimage_entrypoint.sh"]
EXPOSE 9000

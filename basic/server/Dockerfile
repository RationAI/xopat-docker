FROM ubuntu:20.04
WORKDIR /usr/app
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        dos2unix \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/xkacenga/iipsrv.git

COPY ports.conf .
COPY iipimage_conf.conf .
COPY create_tables.sql .
COPY iipimage_entrypoint.sh /usr/local/bin/

RUN chmod 644 create_tables.sql
RUN chmod 755 /usr/local/bin/iipimage_entrypoint.sh
RUN dos2unix /usr/local/bin/iipimage_entrypoint.sh

WORKDIR /usr/app/iipsrv
RUN apt update && apt install -y g++ autoconf libtool pkg-config libjsoncpp-dev libvips-dev libpqxx-dev apache2 libapache2-mod-fcgid postgresql --fix-missing
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
ENTRYPOINT ["iipimage_entrypoint.sh"]
EXPOSE 9000

#based on https://github.com/antage/docker-iipimage-server/blob/master/Dockerfile

FROM debian:stable

# Move scripts & conf files
COPY ./iipsrv.fcgi /usr/lib/iipimage-server/iipsrv.fcgi
# Set as executable
RUN chmod 775 /usr/lib/iipimage-server/iipsrv.fcgi

RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libfcgi \
        libgomp1 \
        libpng16-16 \
        libjpeg62-turbo \
        libvips \ 
#        libmemcached11 \
#        libopenjp2-7 \
#        libtiff5 \
        lighttpd \
    && mkdir -p /var/run/lighttpd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./lighttpd.conf /etc/lighttpd/lighttpd.conf

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

EXPOSE 9000

RUN set -ex \
    && ln -sfT /dev/stderr "/var/log/lighttpd/error.log" \
    && ln -sfT /dev/stderr "/var/log/lighttpd/access.log" \
    && ln -sfT /dev/stderr "/var/log/iipsrv.log"
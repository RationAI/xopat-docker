#!/bin/bash

#from https://github.com/antage/docker-iipimage-server/blob/master/docker-entrypoint.sh
set -e

if [ "$CREATE_USER_UID" -a "$CREATE_USER_GID" ]; then
    echo "Create 'site-owner' group with GID=$CREATE_USER_GID"
    groupadd -g $CREATE_USER_GID site-owner
    echo "Add '${RUN_AS_USER:-nobody}' user to group 'site-owner'"
    usermod -a -G site-owner ${RUN_AS_USER:-nobody}
    echo "Create 'site-owner' user with UID=$CREATE_USER_UID, GID=$CREATE_USER_GID"
    useradd -d /var/www -g $CREATE_USER_GID -s /bin/false -M -N -u $CREATE_USER_UID site-owner
fi

if [ "$1" = 'iipimage-server' ]; then
    echo "Starting IIPImage server in foreground on " ${IP} ":" ${PORT_NUMBER}
    #exec gosu ${RUN_AS_USER:-nobody}:${RUN_AS_GROUP:-nogroup} 
    exec spawn-fcgi -f /usr/lib/iipimage-server/iipsrv.fcgi -n -a ${IP} -p ${PORT_NUMBER}
    #echo "Starting server..."
    #systemctl start lighttpd
    #systemctl enable lighttpd
fi

exec "$@"
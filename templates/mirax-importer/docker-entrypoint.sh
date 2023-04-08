#!/bin/bash

# Directories created by the docker image before.
AUTH_FILE="/usr/local/etc/apache/.htpasswd"

if [ -z $XO_BASIC_USER ]; then
    echo "Authentication disabled."
elif [ -s $AUTH_FILE ]; then
    echo "Created authentication" \
       && htpasswd -bc $AUTH_FILE $XO_BASIC_USER "$XO_BASIC_PWD" \
       && echo "SetEnv XO_BASIC_AUTH 5" >> /etc/apache2/.env.apache
else
    echo "Authentication file exists - skipping..."
fi
apache2ctl -D FOREGROUND
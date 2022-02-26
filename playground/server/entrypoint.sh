#!/bin/sh
gunicorn "server:init_app()" --timeout 90 -w 2 --threads ${THREAD_COUNT} -b ${IP}:${PORT_NUMBER}

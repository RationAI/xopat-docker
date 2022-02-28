#!/bin/sh
echo "Gunicorn configuration: Threads ${THREAD_COUNT}. Listening: ${IP}:${PORT_NUMBER}"
gunicorn "server:init_app()" --timeout 90 --workers ${THREAD_COUNT} -b ${IP}:${PORT_NUMBER}

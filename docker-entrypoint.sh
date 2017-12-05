#!/bin/bash

sed -i "s,\${NGINX_BACKEND_ALB_HOST},${NGINX_BACKEND_ALB_HOST}," /etc/varnish/default.vcl
sed -i "s,\${NGINX_BACKEND_ALB_PORT},${NGINX_BACKEND_ALB_PORT}," /etc/varnish/default.vcl

exec "$@"

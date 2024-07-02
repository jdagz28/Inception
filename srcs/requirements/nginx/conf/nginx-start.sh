#!/bin/bash

# exec "$@"

# # Start Nginx
service nginx start

# # Generate the SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=jdagoy.42.fr/UID=jdagoy"

# Keep Nginx running in the foreground
nginx -g 'daemon off;'
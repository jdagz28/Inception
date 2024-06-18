FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl wget

RUN mkdir -p /etc/nginx/ssl

# Generate the SSL certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=jdagoy.42.fr/UID=jdagoy"

# Copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx-start.sh /nginx-start.sh

# Create the WordPress directory
RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT ["./nginx-start.sh"]
CMD ["nginx", "-g", "daemon off;"]

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl wget

RUN mkdir -p /etc/nginx/ssl

# Copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx-start.sh /nginx-start.sh

# Create the WordPress directory
RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT ["./nginx-start.sh"]
CMD ["nginx", "-g", "daemon off;"]

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl wget zsh neofetch git

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx-start.sh /nginx-start.sh

RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

ENTRYPOINT ["./nginx-start.sh"]

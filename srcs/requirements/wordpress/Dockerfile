FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php7.4-fpm php-mysql php-xml php-imagick \
    mariadb-client redis-tools wget vim git netcat mycli zsh neofetch \
    libz-dev libmemcached-dev php-dev build-essential && \
    pecl install redis

RUN echo "extension=redis.so" > /etc/php/7.4/cli/conf.d/redis.ini
RUN echo "extension=redis.so" > /etc/php/7.4/fpm/conf.d/redis.ini

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY /conf/wp_conf.sh /
COPY /conf/create_post.sh /
RUN chmod +x /create_post.sh
RUN chmod +x /wp_conf.sh

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

ENTRYPOINT ["./wp_conf.sh"]

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php7.4-fpm php-mysql php-xml php-imagick mariadb-client wget vim git netcat mycli zsh neofetch 

COPY /conf/wp_conf.sh /
COPY /conf/create_post.sh /
RUN chmod +x /create_post.sh
RUN chmod +x /wp_conf.sh

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

COPY ./conf/.zshrc /root/.

RUN chsh -s /bin/zsh

ENTRYPOINT ["./wp_conf.sh"]

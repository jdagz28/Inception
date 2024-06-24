FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php7.4-fpm php-mysql php-xml php-imagick mariadb-client wget vim git netcat mycli zsh neofetch 

COPY /conf/wp_conf.sh /
COPY /conf/create_post.sh /
RUN chmod +x /create_post.sh
RUN chmod +x /wp_conf.sh

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

ENTRYPOINT ["./wp_conf.sh"]

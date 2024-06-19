FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client wget vim git netcat mycli zsh neofetch

COPY /conf/wp_conf.sh /
RUN chmod +x /wp_conf.sh

RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k

COPY ./conf/.zshrc /root/.
COPY ./conf/cvio-331 /WP_theme

RUN chsh -s /bin/zsh

ENTRYPOINT ["./wp_conf.sh"]

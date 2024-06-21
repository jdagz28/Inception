FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server wget zsh neofetch git

COPY ./conf/mariadb-conf.sh /mariadb-conf.sh
RUN chmod +x /mariadb-conf.sh

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

COPY ./conf/.zshrc /root/.

RUN chsh -s /bin/zsh

ENTRYPOINT ["/mariadb-conf.sh"]

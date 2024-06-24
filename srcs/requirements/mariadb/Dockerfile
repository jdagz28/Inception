FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server wget zsh neofetch git

COPY ./conf/mariadb-conf.sh /mariadb-conf.sh
RUN chmod +x /mariadb-conf.sh

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

ENTRYPOINT ["/mariadb-conf.sh"]

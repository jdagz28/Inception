FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server

COPY ./conf/mariadb-conf.sh /mariadb-conf.sh
RUN chmod +x /mariadb-conf.sh

ENTRYPOINT ["/mariadb-conf.sh"]

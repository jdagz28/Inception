FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vsftpd wget zsh neofetch git

COPY ./conf/ftp_script.sh /
RUN chmod +x /ftp_script.sh

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

CMD ["/ftp_script.sh"]

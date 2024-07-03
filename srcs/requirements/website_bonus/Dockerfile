FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl wget vim git zsh neofetch 

COPY ./conf/homepage /var/www/homepage

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

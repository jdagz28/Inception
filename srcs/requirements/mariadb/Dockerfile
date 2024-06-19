FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server wget zsh neofetch git

COPY ./conf/mariadb-conf.sh /mariadb-conf.sh
RUN chmod +x /mariadb-conf.sh


RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

COPY ./conf/.zshrc /root/.

RUN chsh -s /bin/zsh

ENTRYPOINT ["/mariadb-conf.sh"]

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget zsh neofetch git tar curl

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

RUN curl -L https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -o /usr/bin/cadvisor --silent \
    && chmod +x /usr/bin/cadvisor

ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]

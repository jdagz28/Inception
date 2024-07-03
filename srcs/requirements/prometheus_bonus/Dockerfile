FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget zsh neofetch git tar

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

RUN wget https://github.com/prometheus/prometheus/releases/download/v2.33.5/prometheus-2.33.5.linux-amd64.tar.gz \
    && tar xvf prometheus-2.33.5.linux-amd64.tar.gz \
    && mv prometheus-2.33.5.linux-amd64/prometheus /usr/local/bin/ \
    && mv prometheus-2.33.5.linux-amd64/promtool /usr/local/bin/ \
    && mv prometheus-2.33.5.linux-amd64/consoles /etc/prometheus/ \
    && mv prometheus-2.33.5.linux-amd64/console_libraries /etc/prometheus/ \
    && mv prometheus-2.33.5.linux-amd64/prometheus.yml /etc/prometheus/ \
    && rm -rf prometheus-2.33.5.linux-amd64.tar.gz prometheus-2.33.5.linux-amd64

COPY ./conf/prometheus.yml /etc/prometheus/prometheus.yml

CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus"]
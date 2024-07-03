FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget zsh neofetch git tar curl libfontconfig1 apt-transport-https software-properties-common gnupg musl

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

RUN mkdir -p /monitor/grafana
RUN wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.1.0_amd64.deb \
    && dpkg -i grafana-enterprise_11.1.0_amd64.deb \
    && apt-get install -f -y

COPY ./conf/dashboard.yml /monitor/grafana/conf/provisioning/dashboards/
COPY ./conf/prometheus.yml /monitor/grafana/conf/provisioning/datasources/
COPY ./conf/dashboard.json /monitor/grafana/dashboards/
COPY ./conf/config.ini /monitor/grafana/conf/custom.ini

WORKDIR /monitor/grafana
CMD ["grafana-server"]

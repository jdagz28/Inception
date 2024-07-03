FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget zsh neofetch git tar curl libfontconfig1 apt-transport-https software-properties-common gnupg musl sudo

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

COPY ./conf/zshrc.sh /root/.
RUN chmod +x /root/zshrc.sh
RUN /root/zshrc.sh

RUN useradd -r -s /bin/bash grafana
RUN mkdir -p /monitor/grafana
RUN wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.1.0_amd64.deb \
    && dpkg -i grafana-enterprise_11.1.0_amd64.deb \
    && apt-get install -f -y

COPY ./conf/dashboard.yml /monitor/grafana/conf/provisioning/dashboards/
COPY ./conf/prometheus.yml /monitor/grafana/conf/provisioning/datasources/
COPY ./conf/dashboard.json /monitor/grafana/dashboards/
COPY ./conf/config.ini /monitor/grafana/conf/custom.ini

# Set permissions
RUN chown -R grafana:grafana /monitor/grafana \
    && mkdir -p /usr/share/grafana/data \
    && chown -R grafana:grafana /usr/share/grafana/data

# # Switch to grafana user
# USER grafana

# Set the working directory
WORKDIR /monitor/grafana

# Start Grafana server
CMD ["grafana-server", "--homepath=/usr/share/grafana/", "--config=/monitor/grafana/conf/custom.ini", "cfg:default.paths.provisioning=/monitor/grafana/conf/provisioning"]

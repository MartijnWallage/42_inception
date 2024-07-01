# Use debian:bullseye-slim as the base image
FROM debian:bullseye-slim

# Install necessary packages (Grafana dependencies)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       wget \
       ca-certificates \
       libfontconfig1 \
       adduser \
       tini \
    && rm -rf /var/lib/apt/lists/*

# Download and install Grafana
ENV GRAFANA_VERSION=8.2.5
RUN wget -q https://dl.grafana.com/oss/release/grafana_${GRAFANA_VERSION}_amd64.deb -O /tmp/grafana.deb \
    && dpkg -i /tmp/grafana.deb \
    && rm /tmp/grafana.deb

RUN adduser --system --no-create-home --group grafana \
    && mkdir -p /var/lib/grafana /etc/grafana /usr/share/grafana \
    && chown -R grafana:grafana /var/lib/grafana /etc/grafana /usr/share/grafana

#Copy Grafana configuration file
COPY ./conf/grafana.ini /etc/grafana/grafana.ini
RUN chown grafana:grafana /etc/grafana/grafana.ini

USER grafana

# Grafana configuration
EXPOSE 3000

ENTRYPOINT [ "tini", "--", "/usr/sbin/grafana-server", "--config=/etc/grafana/grafana.ini",  "--homepath=/usr/share/grafana", "cfg:default.paths.logs=/var/log/grafana", "cfg:default.paths.data=/var/lib/grafana", "cfg:default.paths.plugins=/var/lib/grafana/plugins" ]
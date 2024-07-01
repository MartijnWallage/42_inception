# Use debian:bullseye-slim as the base image
FROM debian:bullseye-slim

# Metadata
LABEL maintainer="My Name <me.email@example.com>"

# Install necessary packages (Prometheus dependencies)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       wget \
       ca-certificates \
       tini \
    && rm -rf /var/lib/apt/lists/*

# Download and install Prometheus
ENV PROMETHEUS_VERSION=2.30.3
RUN wget -q https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz -O /tmp/prometheus.tar.gz \
    && tar -xzf /tmp/prometheus.tar.gz -C /tmp \
    && cp /tmp/prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus /usr/local/bin/ \
    && cp /tmp/prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool /usr/local/bin/ \
    && rm -rf /tmp/prometheus*

# Copy Prometheus configuration file
COPY ./conf/prometheus.yml /etc/prometheus/

# Prometheus configuration
EXPOSE 9090

ENTRYPOINT [ "tini", "--" ]

CMD [ "/usr/local/bin/prometheus", \
"--config.file=/etc/prometheus/prometheus.yml", \
"--storage.tsdb.path=/prometheus", \
"--web.console.libraries=/usr/share/prometheus/console_libraries", \
"--web.console.templates=/usr/share/prometheus/consoles" ]

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    wget \
    tini \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O nginx-exporter.tar.gz https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.2.0/nginx-prometheus-exporter_1.2.0_linux_amd64.tar.gz \
    && tar -xzf nginx-exporter.tar.gz \
    && mv nginx-prometheus-exporter /usr/local/bin/ \
    && rm nginx-exporter.tar.gz

EXPOSE 9113

ENTRYPOINT [ "tini", "--", "/usr/local/bin/nginx-prometheus-exporter", "-nginx.scrape-uri", "http://nginx:8080/metrics"]

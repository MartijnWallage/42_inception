FROM debian:bullseye-slim

# Install necessary packages (nginx-exporter dependencies)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    wget \
    tini \
    && rm -rf /var/lib/apt/lists/*

# Download and extract nginx-exporter binary
RUN wget -O nginx-exporter.tar.gz https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.2.0/nginx-prometheus-exporter_1.2.0_linux_amd64.tar.gz \
    && tar -xzf nginx-exporter.tar.gz \
    && mv nginx-prometheus-exporter /usr/local/bin/ \
    && rm nginx-exporter.tar.gz

# Expose port for nginx-exporter (default: 9113)
EXPOSE 9113

# Command to run nginx-exporter
CMD ["/usr/local/bin/nginx-prometheus-exporter", "-nginx.scrape-uri", "http://nginx:8080/metrics"]

ENTRYPOINT [ "tini", "--" ]
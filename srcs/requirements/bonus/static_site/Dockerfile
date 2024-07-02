FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y curl lighttpd tini git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/MartijnWallage/MartijnWallage.github.io.git html

ENTRYPOINT [ "tini", "--", "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

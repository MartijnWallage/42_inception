FROM debian:bullseye-slim

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y redis tini
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/redis.conf /usr/local/etc/redis/redis.conf

ENTRYPOINT [ "tini", "--", "redis-server", "/usr/local/etc/redis/redis.conf" ]
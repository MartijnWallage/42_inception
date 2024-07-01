#FROM nginx:1.26.1

#RUN apt-get update && apt-get install -y \
 #   tini \
  #  && rm -rf /var/lib/apt/lists/*

#COPY ./html /usr/share/nginx/html

# Dockerfile

FROM debian:bullseye-slim

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl lighttpd tini && \
    rm -rf /var/lib/apt/lists/*

# Copy static website files to /var/www/html
COPY ./html /var/www/html

# Start lighttpd service
ENTRYPOINT [ "tini", "--", "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

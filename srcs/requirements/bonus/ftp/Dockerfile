FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vsftpd \
    tini \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/create_ftp_user.sh /tmp/create_ftp_user.sh

RUN chmod +x /tmp/create_ftp_user.sh

ENTRYPOINT ["tini", "--", "/tmp/create_ftp_user.sh" ]

#FROM alpine:3.13

#RUN apk update && apk upgrade && apk add --no-cache \
#    vsftpd tini

#COPY conf/vsftpd.conf /tmp/vsftpd.conf

#  COPY tools/create_ftp_user.sh /tmp/create_ftp_user.sh

#ENTRYPOINT ["tini", "--"]

#RUN chmod +x /tmp/create_ftp_user.sh
#CMD /tmp/create_ftp_user.sh


#FROM debian:bullseye-slim

# Install vsftpd and other necessary packages
#RUN apt-get update && \
#    apt-get install -y vsftpd openssl && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

# Create the directory for secure_chroot_dir
#RUN mkdir -p /var/run/vsftpd/empty && \
#    chown root:root /var/run/vsftpd/empty && \
#    chmod 755 /var/run/vsftpd/empty

# Copy vsftpd configuration file
#COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Copy the script to create FTP user
#COPY ./tools/create_ftp_user.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/create_ftp_user.sh

# Create ssl certificate
#RUN apt-get update && apt-get install -y openssl && apt-get clean && rm -rf /var/lib/apt/lists/*
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/private/vsftpd.crt -subj "/C=DE/ST=Berlin/L=Berlin/O=42/OU=42/CN=ft_services"

# Expose FTP ports
#EXPOSE 20 21 30000-30009

#CMD ["sh", "-c", "/usr/local/bin/create_ftp_user.sh && /usr/sbin/vsftpd /etc/vsftpd.conf"]

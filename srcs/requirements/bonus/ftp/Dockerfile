FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vsftpd \
    tini \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/create_ftp_user.sh /tmp/create_ftp_user.sh

RUN chmod +x /tmp/create_ftp_user.sh

ENTRYPOINT ["tini", "--", "/tmp/create_ftp_user.sh" ]

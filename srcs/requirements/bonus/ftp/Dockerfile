FROM debian:bullseye-slim

# Install vsftpd and other necessary packages
RUN apt-get update && \
    apt-get install -y vsftpd openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the directory for secure_chroot_dir
RUN mkdir -p /var/run/vsftpd/empty && \
    chown root:root /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty

# Copy vsftpd configuration file
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Copy the script to create FTP user
COPY ./tools/create_ftp_user.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_ftp_user.sh

# Expose FTP ports
EXPOSE 20 21 30000-30009

CMD ["sh", "-c", "/usr/local/bin/create_ftp_user.sh && /usr/sbin/vsftpd /etc/vsftpd.conf"]

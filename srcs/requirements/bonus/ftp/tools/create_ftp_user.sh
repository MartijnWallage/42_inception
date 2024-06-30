#!/bin/bash
trap "exit" TERM

# Create the FTP user with the specified username and password
FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASS=$(cat /run/secrets/ftp_password)
useradd -m $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

chown -R ftp:ftp /var/www/wordpress

# Create FTP directory
#mkdir -p /home/$FTP_USER/ftp
#chown nobody:nogroup /home/$FTP_USER/ftp
#chmod a-w /home/$FTP_USER/ftp

# Create directory where files will be uploaded
#mkdir -p /home/$FTP_USER/ftp/upload
#chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/upload
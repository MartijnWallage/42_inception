#!/bin/bash

# Create the FTP user with the specified username and password
useradd -m $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

# Create FTP directory
mkdir -p /home/$FTP_USER/ftp
chown nobody:nogroup /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp

# Create directory where files will be uploaded
mkdir -p /home/$FTP_USER/ftp/upload
chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/upload

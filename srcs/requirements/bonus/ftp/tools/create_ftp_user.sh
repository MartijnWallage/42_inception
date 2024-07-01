#!/bin/bash

# Create the FTP user with the specified username and password
FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASS=$(cat /run/secrets/ftp_password)

if [ ! -f "/etc/vsftpd.conf.bak" ]; then
    mkdir -p /var/www/html
    mkdir -p /var/run/vsftpd/empty
    cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
    mv /tmp/vsftpd.conf /etc/vsftpd.conf

    # Create user without prompting for information
    adduser --disabled-password --gecos "" $FTP_USER
    echo "$FTP_USER:$FTP_PASS" | chpasswd &> /dev/null
    chown -R $FTP_USER:$FTP_USER /var/www/html

    echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null
fi

echo "FTP started on :21"
exec /usr/sbin/vsftpd /etc/vsftpd.conf


# Create the FTP user with the specified username and password
#FTP_USER=$(cat /run/secrets/ftp_user)
#FTP_PASS=$(cat /run/secrets/ftp_password)

#if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

#    mkdir -p /var/www/html

 #   cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
 #   mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

 #   adduser $FTP_USER --disabled-password
 #   echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd &> /dev/null
 #   chown -R $FTP_USER:$FTP_USER /var/www/html

  #  echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null

#fi

#echo "FTP started on :21"
#/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

# Create FTP directory
#mkdir -p /home/$FTP_USER/ftp
#chown nobody:nogroup /home/$FTP_USER/ftp
#chmod a-w /home/$FTP_USER/ftp

# Create directory where files will be uploaded
#mkdir -p /home/$FTP_USER/ftp/upload
#chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/upload
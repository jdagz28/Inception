#!/bin/bash

service vsftpd start

# Check if the FTP_USER already exists
if id "$FTP_USER" &>/dev/null; then
    echo "User $FTP_USER already exists."
else
    # Create the user with disabled password login
    adduser --disabled-password --gecos "" $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    echo "$FTP_USER" >> /etc/vsftpd.userlist
fi

# Create necessary directories and set permissions
mkdir -p /home/$FTP_USER/ftp/files
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER/ftp

# Update vsftpd configuration
sed -i -r "s/#write_enable=YES/write_enable=YES/1" /etc/vsftpd.conf
sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1" /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/home/$FTP_USER/ftp
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

# Restart vsftpd service
service vsftpd stop
/usr/sbin/vsftpd

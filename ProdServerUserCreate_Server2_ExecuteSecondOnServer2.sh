#!/bin/bash
if [ ! -z "$1" ]
then
# Step 1
useradd "$1"
passwd "$1"
# echo "$1:$1bqDSQye&-4aT" | chpasswd
usermod -s /sbin/nologin "$1"
usermod -a -G ftp "$1"
usermod -a -G ftp_write "$1"

# Step 2
# create user preferred directories in home directory and in shared mount directory.

mkdir /home/"$1"/pickup
# mkdir /mnt/boomi_sftp_mount/ftp/data/pickup_"$1"
# mkdir /mnt/SFTP_Mount_Test/ftp/data/pickup_"$1"

# Step 3:
chown "$1":ftp_write /home/"$1"/
chmod 500 /home/"$1"/
chown -R "$1":ftp_write /mnt/boomi_sftp_mount/ftp/data/pickup_"$1"
# chown -R "$1":ftp_write /mnt/SFTP_Mount_Test/ftp/data/pickup_"$1"

# Step 4:
# run this command to bind user home dir to shared dir:
mount --bind /mnt/boomi_sftp_mount/ftp/data/pickup_"$1"/  /home/"$1"/pickup/
# mount --bind /mnt/SFTP_Mount_Test/ftp/data/pickup_"$1"/  /home/"$1"/pickup/

# Step 5
# Add below line in /etc/fstab for permanent bind
# /mnt/entiredir /home/user/dir none bind 0 0
# /mnt/boomi_sftp_mount/ftp/data/pickup_"$1"/  /home/"$1"/pickup/ none bind 0 0
# echo "\n" >> /etc/fstab
# echo "/mnt/SFTP_Mount_Test/ftp/data/pickup_$1/  /home/$1/pickup/ none bind 0 0" >> /etc/fstab
echo "/mnt/boomi_sftp_mount/ftp/data/pickup_$1/  /home/$1/pickup/ none bind 0 0" >> /etc/fstab
else
echo "Please provide user and re-execute"
fi
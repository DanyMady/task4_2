#!/bin/bash
clear

sudo apt-get install ntp


#change config files

cd ..
cd /etc

sudo sed -i 's/0.ubuntu.pool.ntp.org/ua.pool.ntp.org/g' /etc/ntp.conf
sudo sed -i "s/pool 1.ubuntu.pool.ntp.org iburst/ /g" /etc/ntp.conf
sudo sed -i "s/pool 2.ubuntu.pool.ntp.org iburst/ /g" /etc/ntp.conf
sudo sed -i "s/pool 3.ubuntu.pool.ntp.org iburst/ /g" /etc/ntp.conf
#sed -i 's/original/new/g' file.txt

#restart ntp service

sudo systemctl restart ntp.service

cat ntp.conf > /usr/bin/ntp.original


# adding ntp_verify.sh to cron

(crontab -l 2>/dev/null; echo "* * * * * ntp_verify.sh") | crontab
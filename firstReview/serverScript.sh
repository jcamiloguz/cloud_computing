#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST


server = $1
sudo snap install lxd --channel=4.0/stable
sudo newgrp lxd
sudo lxd init 



sudo lxc launch ubuntu:20.04 web
# sudo lxc exec web --  echo nameserver 8.8.8.8 > /etc/resolv.conf
sudo lxc exec web --  cat /etc/resolv.conf
echo “apt-get update”
sudo lxc exec web --  apt-get update
echo “apt-get apache2”
sudo lxc exec web --  apt-get install -y apache2
sed sed -e '/\$server/s//"$server"/'
sudo lxc file push /shared/index.html web/var/www/html/index.html

sudo lxc config device add web myport80 proxy listen=tcp:$2:5080 connect=tcp:127.0.0.1:80
echo “echo”
sudo lxc exec web -- sudo service apache2 reload
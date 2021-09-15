#!/bin/bash
echo "configurando el resolv.conf con cat"
sudo snap install lxd 
echo "configurando el resolv.conf con cat"
sudo newgrp lxd
echo "configurando el resolv.conf con cat"

sudo lxc launch ubuntu:20.04 web 
# sudo lxc exec web --  echo nameserver 8.8.8.8 > /etc/resolv.conf
sudo lxc exec web --  cat /etc/resolv.conf
echo “apt-get update”
sudo lxc exec web --  apt-get update 
echo “apt-get apache2”
sudo lxc exec web --  apt-get install -y apache2
sudo lxc file push /shared/index.html web/var/www/html/index.html
sudo lxc config device add web myport80 proxy listen=tcp:192.168.100.4:5080 connect=tcp:127.0.0.1:80
echo “echo”
sudo lxc exec web -- sudo service apache2 reload
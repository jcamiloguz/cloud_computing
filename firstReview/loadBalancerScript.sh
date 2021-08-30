#!/bin/bash


sudo snap install lxd
sudo newgrp lxd
sudo lxd init < /shared/init.YML
sudo lxc launch ubuntu:20.04 loadBalancer
sudo lxc exec loadBalancer --  apt update && apt upgrade -y
sudo lxc exec loadBalancer --  apt install haproxy -y
sudo lxc exec loadBalancer --  systemctl enable haproxy
cp -f /etc/haproxy/haproxy.cfg [new file]
sudo lxc config device add haproxy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
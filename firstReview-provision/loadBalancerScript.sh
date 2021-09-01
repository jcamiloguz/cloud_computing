#!/bin/bash

sudo sudo snap install lxd
sudo gpasswd -a vagrant lxd
cat /shared/preseed.yaml | lxd init --preseed
sudo cp /var/snap/lxd/common/lxd/cluster.crt /shared/cluster.crt
sed -i 's/^/    /g' /vagrant/cluster.crt

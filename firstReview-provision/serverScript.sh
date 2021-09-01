#!/bin/bash

sudo sudo snap install lxd
sudo gpasswd -a vagrant lxd
certificado=$(</vagrant/cluster.crt)
cat <<TEST> ~/preseed.yaml
config: {}
networks: []
storage_pools: []
profiles: []
projects: []
cluster:
  server_name: $2
  enabled: true
  member_config:
  - entity: storage-pool
    name: local
    key: source
    value: ""
    description: '"source" property for storage pool "local"'
  cluster_address: 192.168.100.2:8443
  cluster_certificate: |
$certificado
  server_address: $1:8443
  cluster_password: "admin"
  cluster_certificate_path: ""
TEST
cat ~/preseed.yaml
sudo cat ~/preseed.yaml | lxd init --preseed





if[ $3 = 1 ]
then
echo "Generando un contenedor Ubuntu 18.04 HAProxy"
lxc init ubuntu:18.04 HAProxy --target haproxy < /dev/null

echo "Generando un contenedor Ubuntu 18.04 Web1"
lxc init ubuntu:18.04 Web1 --target web1 < /dev/null

echo "Generando un contenedor Ubuntu 18.04 Web1Backup"
lxc init ubuntu:18.04 Web1Backup --target web1 < /dev/null

echo "Generando un contenedor Ubuntu 18.04 Web2"
lxc init ubuntu:18.04 Web2 --target web2 < /dev/null

echo "Generando un contenedor Ubuntu 18.04 Web2Backup"
lxc init ubuntu:18.04 Web2Backup --target web2 < /dev/null

echo "Inicializando los contenedores"
lxc start HAProxy Web1 Web1Backup Web2 Web2Backup

echo "Listando contenedores"
lxc list


lxc restart HAProxy Web1 Web1Backup Web2 Web2Backup

echo "Instalando Apache en el contenedor Web1"
sudo lxc exec Web1 -- apt-get install apache2 -y

echo "Verificando el estado del servicio"
sudo lxc exec Web1 -- systemctl status apache2

echo "Verificando la existencia del index.html"
sudo lxc exec Web1 -- ls /var/www/html

echo "Remplazando el index.html en el contenedor Web1"
sudo lxc file push /shared/Web1/index.html Web1/var/www/html/index.html

echo "Verificando su contenido"
sudo lxc exec Web1 -- cat /var/www/html/index.html

echo "Reiniciando el servicio de apache"
sudo lxc exec Web1 -- systemctl restart apache2

echo "Instalando Apache en el contenedor Web1Backup"
sudo lxc exec Web1Backup -- apt-get install apache2 -y

echo "Verificando el estado del servicio"
sudo lxc exec Web1Backup -- systemctl status apache2

echo "Verificando la existencia del index.html"
sudo lxc exec Web1Backup -- ls /var/www/html

echo "Remplazando el index.html en el contenedor Web1Backup"
sudo lxc file push /shared/Web1Backup/index.html Web1Backup/var/www/html/index.html

echo "Verificando su contenido"
sudo lxc exec Web1Backup -- cat /var/www/html/index.html

echo "Reiniciando el servicio de apache"
sudo lxc exec Web1Backup -- systemctl restart apache2

echo "Instalando Apache en el contenedor Web2"
sudo lxc exec Web2 -- apt-get install apache2 -y

echo "Verificando el estado del servicio"
sudo lxc exec Web2 -- systemctl status apache2

echo "Verificando la existencia del index.html"
sudo lxc exec Web2 -- ls /var/www/html

echo "Remplazando el index.html en el contenedor Web2"
sudo lxc file push /shared/Web2/index.html Web2/var/www/html/index.html

echo "Verificando su contenido"
sudo lxc exec Web2 -- cat /var/www/html/index.html

echo "Reiniciando el servicio de apache"
sudo lxc exec Web2 -- systemctl restart apache2

echo "Instalando Apache en el contenedor Web2Backup"
sudo lxc exec Web2Backup -- apt-get install apache2 -y

echo "Verificando el estado del servicio"
sudo lxc exec Web2Backup -- systemctl status apache2

echo "Verificando la existencia del index.html"
sudo lxc exec Web2Backup -- ls /var/www/html

echo "Remplazando el index.html en el contenedor Web2Backup"
sudo lxc file push /shared/Web2Backup/index.html Web2Backup/var/www/html/index.html

echo "Verificando su contenido"
sudo lxc exec Web2Backup -- cat /var/www/html/index.html

echo "Reiniciando el servicio de apache"
sudo lxc exec Web2Backup -- systemctl restart apache2

echo "Instalando HAProxy en el contenedor HAProxy"
sudo lxc exec HAProxy -- apt-get install haproxy -y

echo "Habilitando HAProxy"
sudo lxc exec HAProxy -- systemctl enable haproxy

echo "Configurando haproxy.cfg"
sudo lxc file push /shared/haproxy.cfg HAProxy/etc/haproxy/haproxy.cfg

echo "Configurando página personalizada"
sudo lxc file push /shared/503.http HAProxy/etc/haproxy/errors/503.http

echo "Iniciando HAProxy"
sudo lxc exec HAProxy -- systemctl start haproxy

sudo lxc config device add HAProxy http proxy listen=tcp:192.168.100.2:80 connect=tcp:127.0.0.1:80

fi
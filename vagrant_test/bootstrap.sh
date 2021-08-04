#!/usr/bin/env bash
apt-get update
apt-get install -y apache2
yes | cp /shared/index.html /var/www/html
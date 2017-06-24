#!/bin/bash

# install python 2
apt-get -y install software-properties-common
apt-get -y install python-simplejson
apt-get -y update
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
apt-get -y update
apt-get -y install sshpass

# make www directory
mkdir /var/www

# Windows make empty fpm script and make it executable
touch /home/vagrant/fpm.sh
chmod +x /home/vagrant/fpm.sh

# Adding multiverse sources for libapache-fastcgi
chmod +x /etc/apt/sources.list.d
cat > /etc/apt/sources.list.d/multiverse.list << EOF
deb http://archive.ubuntu.com/ubuntu trusty multiverse
deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse
deb http://security.ubuntu.com/ubuntu trusty-security multiverse
EOF

echo 'vagrant ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

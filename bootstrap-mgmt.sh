#!/bin/bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible
apt-get -y install sshpass
apt-get -y update

#add n=vagrant to sudo w/o asking for pw
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

# copy examples into /home/vagrant (from inside the mgmt node) and cd to install keys
cp -a /vagrant/ansible/* /home/vagrant
cd /home/vagrant

#install ssh-keys
ssh-keygen -t rsa -b 2048 -N "" -f /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id*

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
192.168.45.13  testmgmt
192.168.45.23  test.dev
EOL

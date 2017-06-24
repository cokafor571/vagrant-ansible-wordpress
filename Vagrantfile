# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # create mgmt node
  config.vm.define :mgmt do |mgmt_config|
      mgmt_config.vm.box = "bento/ubuntu-16.04"
      mgmt_config.vm.synced_folder ".", "/vagrant/"
      mgmt_config.vm.hostname = "mgmt"
      mgmt_config.vm.network :private_network, ip: "192.168.45.13"
      mgmt_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "testmgmt"
      end
      mgmt_config.vm.provision :shell, path: "bootstrap-mgmt.sh"
  end

    config.vm.define :development do |development_node|
        development_node.vm.box = "bento/ubuntu-16.04"
        development_node.vm.synced_folder ".", "/vagrant/"
        development_node.vm.hostname = "development"
        development_node.vm.network :private_network, ip: "192.168.45.23"
        development_node.vm.network "forwarded_port", guest: 80, host: "9092"
        development_node.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
          vb.name = "test.dev"
        end
        development_node.vm.provision :shell, path: "bootstrap-development.sh"
    end
end

Wordpress Development Environment from Scratch Using _S for Eventual Production on Digital Ocean

Guide uses Vagrant / Virtualbox / Ansible / Gulp

Ansible installs

    Php 7.1

    Mysql latest verion

    Apache latest version
        configured with fast-cgi and php-fpm for php processing

    WP-Cli for easy WP manipulation 

To initiate in terminal

1. git clone (repository) or cd into 

2. wget https://wordpress.org/latest.tar.gz (if wp is not present and/or you want newest version)

3. unzip wordpress using: tar -xzvf latest.tar.gz 

    copy starterpack folder (_S theme with most basic styles) into wp-content/themes

        copy gulp-dev into wp-content/themes
            aside: gulp is run to process sass / js(if needed) and eventually optimize WP for production

4. Vangrantfile:

    change:

        mgmt node vb.name = {value}

        devlopment node vb.name = {value}

        mgmt node vb.network / ip = {value}
        
        devlopment node vb.network / host = {value}

5. bootstrap-mgmt.sh 

    change:

        #vagrant environment nodes

        make sure ip && name match ip && name in Vagrantfile

5b. ansible/inventory.ini 

     change:

        add { devlopment node vb.name = {value} }

6. vagrant up   

    once complete vagrant status to make sure everything is ok

    vagrant ssh mgmt

7. Inside mgmt vagrant box

    sudo apt-get update

    sudo apt-get upgrade (this may take a while depending on linux version installed) 

        aside: may see options to install grub - boot from smallest disk size here

    ssh vagrant@{ devlopment node vb.name = {value} } ( answer yes )

8. Inside development vagrant box

    sudo apt-get -y install software-properties-common

    sudo LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

    sudo apt-get update

    sudo apt-get upgrade (this may take a while depending on linux version installed) 

        aside: may see options to install grub - boot from smallest disk size here

    exit (takes you back to mgmt node)

9. Ansible provision development node from mgmt

    ansible-playbook ssh.yml --ask-pass ( pw = vagrant )

    ansible-playbook setup.yml

10. Prepare development node to use FPM/Fast-CGI php processing

     ssh vagrant@{ devlopment node vb.name = {value} }

     sudo nano fpm.sh and copy contents( from fpm.sh file into terminal fpm.sh )

     sudo ./fpm.sh

     sudo service apache2 restart

     sudo service php7.1-fpm restart

     aside: place an info.php ( <?php info(); ) at root of WP to check if FPM/Fast-CGI is installed correctly

11. Begin Devlopment in Browser 

     a. cd into gulp-dev and run gulp 
     
     and or
     
     b. on main OS edit /etc/hosts file ( system32/drivers/etc/hosts in Windows ) and write ip and development node name
        type name into browser to start development

Finish 

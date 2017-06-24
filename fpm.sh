#!/bin/bash

# ---------------------------------------
#          Virtual Machine Setup
# ---------------------------------------

# On windows to run this script it must be copied to the linux environment

# Fallback multiverse sources. 
chmod +x /etc/apt/sources.list.d
cat > /etc/apt/sources.list.d/multiverse.list << EOF
deb http://archive.ubuntu.com/ubuntu trusty multiverse
deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse
deb http://security.ubuntu.com/ubuntu trusty-security multiverse
EOF


# Creating the configurations inside Apache
chown -R www-data:www-data /usr/lib/cgi-bin
cat > /etc/apache2/conf-available/php7.1-fpm.conf << EOF
<IfModule mod_fastcgi.c>
    AddHandler php7.1-fcgi .php
    Action php7.1-fcgi /php7.1-fcgi
    Alias /php7.1-fcgi /usr/lib/cgi-bin/php7.1-fcgi
    FastCgiExternalServer /usr/lib/cgi-bin/php7.1-fcgi -socket /var/run/php/php7.1-fpm.sock -pass-header Authorization -idle-timeout 3600

    # NOTE: using '/usr/lib/cgi-bin/php7.1-cgi' here does not work,
    #   it doesn't exist in the filesystem!
    <Directory /usr/lib/cgi-bin>
        Require all granted
    </Directory>

</IfModule>
EOF

# Enabling php modules
phpenmod mcrypt

# Triggering changes in apache
a2enconf php7.1-fpm

a2dismod mpm_prefork

a2enmod mpm_event actions fastcgi alias 

service apache2 restart && service php7.1-fpm restart

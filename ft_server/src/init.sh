#!/bin/bash

mkdir /var/www/localhost

autoindex_on="nginx/localhost_autoindex_on"
autoindex_off="nginx/localhost_autoindex_off"
localhost="/etc/nginx/sites-available/localhost"

echo "type in \"on\" if you want autoindex on, \"off\" if you want autoindex off"
read user_input
if [ $user_input == "on" ]
then
	echo "autoindex on"
	cat $autoindex_on > $localhost
elif [ $user_input == "off" ]
then
	echo "autoindex off"
	cat $autoindex_off > $localhost
else
	echo "invalid input. using default (on)"
	cat $autoindex_on > $localhost
fi

ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

mv wordpress /var/www/localhost/wordpress
mv phpMyAdmin-5.1.0 /var/www/localhost/phpMyAdmin

chown -R www-data:www-data /var/www/*

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'wpuser'@'localhost';" | mysql -u root
echo "SET password FOR 'wpuser'@'localhost' = password('password');    " | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

cd ssl
chmod +x mkcert
./mkcert -install
./mkcert localhost
cd ..

chmod +x switch.sh

service nginx reload
service nginx configtest
service nginx start
service nginx status
service php7.3-fpm start
service php7.3-fpm status

bash
# tail -f /var/log/nginx/access.log /var/log/nginx/error.log
# ./switch.sh
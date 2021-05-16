#!/bin/sh

mkdir /var/www/localhost

cp localhost /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

cp -r wordpress /var/www/localhost/wordpress
cp -r phpMyAdmin-5.1.0 /var/www/localhost/phpMyAdmin

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

service nginx reload
service nginx configtest
service nginx start
service nginx status
service php7.3-fpm start
service php7.3-fpm status

tail -f /var/log/nginx/access.log /var/log/nginx/error.log
#!/bin/bash

is_autoindex=1

autoindex_on="/nginx/localhost_autoindex_on"
autoindex_off="/nginx/localhost_autoindex_off"
localhost="/etc/nginx/sites-available/localhost"

fn_switch()
{
	if [ $is_autoindex -eq 1 ]
	then
		cat $autoindex_off > $localhost
		is_autoindex=0
	else
		cat $autoindex_on > $localhost
		is_autoindex=1
	fi
	service nginx restart
	service mysql restart
	service php7.3-fpm restart
}

while :
do
	echo "type in S to switch X to exit T to run tails. enter to validate"
	read user_input
	if [ $user_input == "S" ]
	then
		fn_switch
	elif [ $user_input == "T" ]
	then
		tail -f /var/log/nginx/access.log /var/log/nginx/error.log
	elif [ $user_input == "X" ]
	then
		break
	else
		echo "wrong input. no whitespaces either."
	fi
done
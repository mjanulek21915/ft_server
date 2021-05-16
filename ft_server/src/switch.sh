#!/bin/bash

autoindex_on="/nginx/localhost_autoindex_on"
autoindex_off="/nginx/localhost_autoindex_off"
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
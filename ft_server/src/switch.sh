#!/bin/bash
AUTOINDEX="on"

localhost="/etc/nginx/sites-available/localhost"

if [ "$AUTOINDEX" == "on" ]
then
	int_status=1
elif [ "$AUTOINDEX" == "off" ]
then
	int_status=0
else
	echo "Something went wrong. Unknown AUTOINDEX string"
	echo "AUTOINDEX : |$AUTOINDEX|"
	echo "shutting down"
	exit
fi


fn_switch_autoindex() {
	if [ $int_status -eq 1 ]
	then
		sed -i 's/autoindex on/autoindex off/' $localhost
		int_status=0
		return
	elif [ $int_status -eq 0 ]
	then
		sed -i 's/autoindex off/autoindex on/' $localhost
		int_status=1
		return
	fi
}



echo "this is the main loop for the container. ctrl + C to close the container"
while :
do
	echo "type B for bash, S to switch autoindex, X to exit"
	echo "press enter to validate."
	if [ $int_status -eq 1 ]
	then
		echo "autoindex is on"
	elif [ $int_status -eq 0 ]
	then
		echo "auntoindex is off"
	else
		echo "value is something weir"
		echo "int_status : |$int_status|"
	fi

	read user_input
	user_input=$(echo $user_input | sed 's/ //')
	echo " "
	if [[ "$user_input" == "b" || "$user_input" == "B" ]]
	then
		echo "bash"
		bash
	elif [[ "$user_input" == "s" || "$user_input" == "S" ]]
	then
		echo "fn_switch_autoindex"
		fn_switch_autoindex
		echo "service nginx restart"
		service nginx restart
	elif [[ "$user_input" == "x" || "$user_input" == "X" ]]
	then
		exit
	else
		echo "|$user_input| is not a valid entry."
	fi
done
#!/bin/bash

is_autoindex=1

while :
do
	echo "type in S to switch X to exit T to run tails. enter to validate"
	read user_input
	if [ "$user_input" == "S" ]
	then
		echo $user_input
	elif [ "$user_input" == "T" ]
	then
		echo $user_input
	elif [ "$user_input" == "X" ]
	then
		break
	else
		echo "your input was :"
		echo "|$user_input|"
		echo "wrong input. no whitespaces either."
	fi
done


# read -p "Enter a string: " str1
  
# if [ $str1 == "linux" ]
# then
#     echo "linux"
# elif [ $str1 == "unix" ]
# then
#     echo "unix"
# else
#     echo "Neither linux nor unix"
# fi
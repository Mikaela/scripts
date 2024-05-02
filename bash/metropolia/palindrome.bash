#!/usr/bin/env bash

while true; do
	# Neovim complains about mangling backslashes if -r is not specified and
	# I have learned to listen to its warnings
	read -rp "What would you like to check for a palindrome?: " inputted
	reversed=$(echo "$inputted" | rev)
	echo "$reversed"

	if [[ $inputted == "$reversed" ]]; then
		break
	fi
done

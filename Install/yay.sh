#!/bin/bash
sudo pacman -Sy
sudo pacman -S yay
sudo yay -Sy

for i in $@; do
	set +e
	while read -r line; do
		cleanline=`echo -n $line | tr -d "\n"`
		if [[ ! -z $cleanline ]]; then
			yes | sudo yay -S $cleanline
		fi
	done < "$i"
	set -e
done

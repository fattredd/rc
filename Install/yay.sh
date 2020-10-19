#!/bin/bash
sudo pacman -Sy
sudo pacman -S yay
sudo yay -Sy

for i in $@; do
	set +e
	while read -r line; do
		if [[ ! -z $line ]]; then
			yes | sudo yay -S $line
		fi
	done < "$i"
	set -e
done

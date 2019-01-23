#!/bin/bash
sudo pacman -Syu

for i in $@; do
	set +e
	while read -r line; do
		if [[ ! -z $line ]]; then
			yes | sudo pacman -S $line
		fi
	done < "$i"
	set -e
done

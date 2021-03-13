#!/bin/bash
sudo pacman -Syu

for i in $@; do
	set +e
	while read -r line; do
		cleanline=`echo -n $line | tr -d "\n"`
		if [[ ! -z $cleanline ]]; then
			yes | sudo pacman -S $cleanline
		fi
	done < "$i"
	set -e
done

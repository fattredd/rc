#!/bin/bash

# Not working for some reason

sudo add-apt-repository universe
sudo apt update 
sudo apt upgrade -y

for i in $@; do
	set +e
	while read -r line; do
		if [[ ! -z $line ]]; then
			sudo apt-get install -y $line
		fi
	done < "$i"
	set -e
done

sudo apt autoremove

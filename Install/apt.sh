#!/bin/bash

sudo add-apt-repository universe
sudo apt update 
sudo apt upgrade -y

for i in $@; do
	set +e
	while read -r line; do
		cleanline=`echo -n $line | tr -d "\n"`
		if [[ ! -z $cleanline ]]; then
			sudo apt-get install -y $cleanline
		fi
	done < "$i"
	set -e
done

sudo apt autoremove

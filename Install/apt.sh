#!/bin/bash

sudo add-apt-repository universe
sudo apt-get -qq update 
sudo apt-get upgrade -y

for i in $@; do
	set +e
	while read -r line; do
		cleanline=`echo -n $line | tr -d "\n"`
		if [[ ! -z $cleanline ]]; then
			sudo apt-get -qq install -y $cleanline
		fi
	done < "$i"
	set -e
done

sudo apt-get -qq autoremove

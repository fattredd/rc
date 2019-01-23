#!/bin/bash
sudo apt update & sudo apt upgrade -y

for i in $@; do
	set -e
	while read -r line; do
		sudo apt install "$line"
	done < "$i"
	set +e
done
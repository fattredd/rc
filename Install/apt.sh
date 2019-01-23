#!/bin/bash
sudo apt update && apt upgrade -y

for i in $@; do
	set +e
	while read -r line; do
		if [[ ! -z $line ]]; then
			sudo apt update -y $line
		fi
	done < "$i"
	set -e
done
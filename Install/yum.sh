#!/bin/bash

sudo yum update -q -y
sudo yum install -y -q yum-utils
sudo yum upgrade -y

for i in $@; do
	set +e
	while read -r line; do
		cleanline=`echo -n $line | tr -d "\n"`
		if [[ ! -z $cleanline ]]; then
			sudo yum install -q -y $cleanline
		fi
	done < "$i"
	set -e
done

sudo yum -q -y autoremove


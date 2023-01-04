#!/bin/bash

cnt_name=${1:-"dev-env"}
echo "Connecting to $cnt_name container"

working_dir="$(realpath --relative-base="$HOME" .)"
echo "Trying to find ~/$working_dir..."

docker exec $cnt_name bash -c "[ -d \$(pwd)/$working_dir ]"
dirFound=$?
internal_path=
if [ $dirFound -eq 0 ]; then
    internal_path="$(docker exec $cnt_name bash -c "echo \$(pwd)/$working_dir")"
    echo "  in dir: ~/$working_dir"

else
    echo "  Local dir not found in $cnt_name"
fi

docker exec -it -w "$internal_path" $cnt_name /bin/bash


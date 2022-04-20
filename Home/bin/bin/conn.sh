#!/bin/bash

echo "Connecting to devex container"

working_dir="$(realpath --relative-base="$HOME" .)"
echo "Trying to find ~/$working_dir..."

docker exec devex bash -c "[ -d \$(pwd)/$working_dir ]"
dirFound=$?
internal_path=
if [ $dirFound -eq 0 ]; then
    internal_path="$(docker exec devex bash -c "echo \$(pwd)/$working_dir")"
    echo "  in dir: ~/$working_dir"

else
    echo "  Local dir not found in container"
fi

docker exec -it -w "$internal_path" devex /bin/bash


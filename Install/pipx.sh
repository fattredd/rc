#!/bin/bash

set -e

packages=(yq thefuck)

pip3 install pipx
pipx ensurepath
for i in ${packages[@]}; do
  pipx install $i
done

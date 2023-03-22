#!/usr/bin/env bash

set -e

packages=(build-essential cmake vim-nox python3-dev mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm)

if command -v nala &>/dev/null; then
  pkg=nala
elif command -v apt &>/dev/null; then
  pkg=apt
elif command -v dnf &>/dev/null; then
  pkg=dnf
elif command -v yum &>/dev/null; then
  pkg=yum
fi

sudo $pkg install -y ${packages[@]}

cur_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

pushd ${cur_dir}/../Home/
  stow -t ~ vim
popd

vim -c ':PlugInstall' '+:qa!'

pushd ~/.vim/plugged/youcompleteme/
  python3 install.py --all
popd

green="\e[32m"
reset="\e[0m"
check="\xE2\x9C\x85"
echo -e ${green}${check}YouCompleteMe installed${reset}

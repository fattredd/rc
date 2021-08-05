#!/bin/bash
sudo apt update

bash ./apt.sh all dev &&
bash ./python.sh &&

ssh-import-id-gh fattredd

cd ../Home
set -e
rm ~/.bashrc ~/.bash_logout ~/.inputrc
stow -t ~ {shell,bin,git,tmux}

mkdir -p ~/Source
source ~/.bashrc
tldr -u

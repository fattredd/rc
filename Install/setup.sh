#!/bin/bash
sudo apt update

ssh-import-id-gh fattredd

bash ./apt.sh all dev &&
bash ./python.sh &&

cd ../Home
rm ~/.bashrc ~/.bash_logout ~/.inputrc
stow -t ~ {shell,bin,git,tmux}

mkdir -p ~/Source

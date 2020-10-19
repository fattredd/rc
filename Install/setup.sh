#!/bin/bash
sudo apt update

bash ./apt.sh all dev &
bash ./python.sh &

cd ../Home
rm ~/.bashrc ~/.bash_logout ~/.inputrc
stow -t ~ {shell,bin,git,tmux}

mkdir -p ~/Source
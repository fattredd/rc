#!/bin/bash
sudo apt update

bash ./apt.sh

cd ../Home
rm ~/.bashrc ~/.bash_logout
stow -t ~ {shell,bin,git,tmux}

mkdir ~/Source
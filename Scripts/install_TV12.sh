#!/bin/bash

cd /tmp/
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install ./teamviewer_amd64.deb
sudo teamviewer repo tv12
sudo apt update
sudo apt install -y teamviewer-host=12.1.83885
sudo teamviewer setup
sudo teamviewer daemon start

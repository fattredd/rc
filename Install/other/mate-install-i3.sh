#!/usr/bin/env bash
#
# Setup i3-wm to work inside Mate-DE

pkgmgr="yum"

sudo ${pkgmgr} -y install dconf-editor i3 xorg-x11-utils

# https://mattgreer.dev/blog/mate-and-i3/
#
sudo pip3 install i3-cycle

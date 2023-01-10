#!/usr/bin/env bash

# Setup i3-wm to work inside Mate-DE

pkgmgr="yum"

sudo ${pkgmgr} -y install i3 xorg-x11-utils dconf-editor
sudo pip3 install i3-cycle

# Not all of this is relevant, but
# https://mattgreer.dev/blog/mate-and-i3/
# 
# Basically says use dconf-editor to:
#   `org > mate > desktop > session > required-components`
#     `windowmanager` change `marco` to `i3`
#     `panel` change `mate-panel` to `` 
#
#   `org > mate > desktop > session`
#     `required-components-list` remove `filemanager` and `panel`
#
# But why do that manually?
sess="/org/mate/desktop/session"
req="${sess}/required-components"
dconf write ${req}/windowmanager "'i3'"
dconf write ${req}/panel "''"

old_list=`dconf read ${req}-list`
new_list=`echo $old_list | sed -e "s/, 'panel', 'filemanager'//"`
dconf write ${req}-list "${new_list}"

# Now all we need to do is unstow our i3 files.
#   But like, new versions of i3 are _way_ better, so we might want to
#   do something about dealing with that?

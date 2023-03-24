#!/bin/bash

set -e

# Check if we have everything we need
function isCmd() {
  command -v $@ &> /dev/null
}
function passCmd() {
  $@ &> /dev/null
}

[ "$1" == "dryrun" ] && shift 1 && dry="echo" # Allow us to just show the commands, not run them

# First figure out the pkg manager, deps, and sudo-ability
if ! isCmd python3 || ! isCmd jq; then
  { isCmd sudo && sudo="$dry sudo"; } || sudo="$dry"
  {
    { isCmd apt && pkg="apt install -y"; } ||
    { isCmd dnf && pkg="dnf install -y"; } ||
    { isCmd yum && pkg="yum install -y"; } ||
    { isCmd apk && pkg="apk add"; };
  }

  [ -z "${pkg}" ] && echo "No package manager detected" && exit 1

  # Install missing
  isCmd python3 || $sudo $pkg python3
  isCmd jq || $sudo $pkg jq
fi

passCmd python3 -m ensurepip -h || $sudo $pkg python3-pip
passCmd python3 -m venv -h || $sudo $pkg python3-venv
passCmd python3 -m pipx -h || $dry python3 -m pip install pipx
[ -n "`echo $PATH | grep '\.local/bin'`" ] || $dry python3 -m pipx ensurepath
isCmd yq || $dry python3 -m pipx install yq

packages=(yq thefuck)

for i in ${packages[@]}; do
  pipx install $i
done

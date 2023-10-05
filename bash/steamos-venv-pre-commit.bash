#!/usr/bin/env bash
# This is a noteish on how to pre-commit on SteamOS
set -x

cd ~
mkdir -p ~/.local/bin/
# My pre-commit configuration expects to find a pypy
ln -sf /usr/bin/python ~/.local/bin/pypy
ln -sf /usr/bin/python3 ~/.local/bin/pypy3

mkdir -p ~/venv
python3 -m venv ~/venv
. ~/venv/bin/activate
python3 -m pip install pip --upgrade
python3 -m pip install pre-commit --upgrade
# Removes duplicates from $PATH. Copied from https://unix.stackexchange.com/a/14896
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')
printf "Remember to apply the following somewhere appropiate:\nPATH=$PATH"

set +x

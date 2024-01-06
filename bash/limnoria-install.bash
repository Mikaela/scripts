#!/usr/bin/env bash

# This is just a quick script to install Limnoria alongside optional
# dependencies and dependencies of the plugins or repositories I use.

set -x

PYTHON=python3

mkdir -p ~/venv
$PYTHON -m venv ~/venv
. ~/venv/bin/activate
$PYTHON -m pip install pip --upgrade
$PYTHON -m pip install git+https://github.com/ProgVal/Limnoria.git@testing --upgrade
$PYTHON -m pip install -r https://github.com/progval/Limnoria/raw/testing/requirements.txt --upgrade
$PYTHON -m pip install -r https://github.com/progval/Supybot-plugins/raw/master/requirements.txt --upgrade
$PYTHON -m pip install -r https://github.com/jlu5/SupyPlugins/raw/master/requirements.txt --upgrade
$PYTHON -m pip install -r https://github.com/oddluck/limnoria-plugins/raw/master/requirements.txt --upgrade

# Removes duplicates from $PATH. Copied from https://unix.stackexchange.com/a/14896
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')
printf "Remember to apply the following somewhere appropiate:\nPATH=$PATH\n"

set +x

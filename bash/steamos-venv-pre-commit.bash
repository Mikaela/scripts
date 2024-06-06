#!/usr/bin/env bash
# This is a noteish on how to pre-commit on SteamOS. Or it was, but then I
# decided that pipx is a thing that I could put into the venv more reasonably
# and feel less bad about abusing it O:)
set -x

# In case there is some valid reason to use different Python
PYTHON=python3

cd ~
mkdir -p ~/.local/bin/

# My pre-commit configuration expects to find a pypy which SteamOS doesn't
# come with and it was the original motivation for this script, so it's
# difficult to start changing anything here. If you don't want it, just
# install pypy or symlink it in path yourself!
if ! hash pypy 2> /dev/null; then
	ln -sf /usr/bin/python ~/.local/bin/pypy
fi
if ! hash pypy3 2> /dev/null; then
	ln -sf /usr/bin/python3 ~/.local/bin/pypy3
fi

mkdir -p ~/venv
$PYTHON -m venv ~/venv
. ~/venv/bin/activate
$PYTHON -m pip install pip --upgrade
$PYTHON -m pip install pipx --upgrade
$PYTHON -m pipx install pre-commit
$PYTHON -m pipx upgrade-all

# As this script claims to be pre-commit on SteamOS, let's do it properly all
# the way!
mkdir -p ~/.git-template
git config --global init.templatedir ~/.git-template
pre-commit init-templatedir ~/.git-template

# Removes duplicates from $PATH. Copied from https://unix.stackexchange.com/a/14896
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')
printf "Remember to apply the following somewhere appropiate:\nPATH=$PATH"

set +x

#!/usr/bin/env bash

if [[ $USER != "root" ]]; then
    NOROOT="--user"
fi

pip --version
sleep 10

# Install requirements, commented as they don't exist.
#pip install -vr https://raw.githubusercontent.com/rg3/youtube-dl/master/requirements.txt --upgrade $NOROOT
pip install -v git+https://github.com/rg3/youtube-dl.git --upgrade $NOROOT

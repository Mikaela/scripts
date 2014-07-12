#!/usr/bin/env bash
if [[ $USER != "root" ]]; then
    NOROOT="--user"
fi

pip3 install -vr https://raw.githubusercontent.com/ProgVal/Limnoria/testing/requirements.txt --upgrade $NOROOT $1
## VERY EXPERIMENTAL, BROKEN AND DOES NOT EXIST!
#pip install -vr https://raw.githubusercontent.com/ProgVal/Limnoria/master/requirements.vcs.txt --upgrade $NOROOT $1
pip3 install -v git+https://github.com/ProgVal/Limnoria.git@testing --upgrade $NOROOT $1

# ProgVal/Supybot-plugins
pip3 install -vr https://raw.githubusercontent.com/ProgVal/Supybot-plugins/master/requirements.txt --upgrade $NOROOT $1

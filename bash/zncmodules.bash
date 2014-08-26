#!/usr/bin/env bash
# This script downloads external ZNC modules which I use.
cd znc
cd modules
echo "Downloading kvirc.cpp"
curl -LO https://raw.githubusercontent.com/DarthGandalf/znc/dgmods/modules/kvirc.cpp
#echo "Downloading otr.cpp"
#curl -LO https://raw.githubusercontent.com/mmilata/znc-otr/master/otr.cpp
echo "Downloading privmsg.cpp"
curl -LO https://raw.githubusercontent.com/kylef/znc-contrib/master/privmsg.cpp

# ~/.znc/modules
mkdir -p ~/.znc/modules
cd ~/.znc/modules
echo "Downloading push.py"
curl -LO https://raw.githubusercontent.com/jreese/znc-push/python/push.py

echo "You can now run zncconfigure.bash"


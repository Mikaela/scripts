#!/usr/bin/env bash
# This script downloads external ZNC modules which I use.
set -x
cd znc
cd modules
echo "Downloading kvirc.cpp"
curl -LO https://raw.githubusercontent.com/DarthGandalf/znc/dgmods/modules/kvirc.cpp
#echo "Downloading otr.cpp"
#curl -LO https://raw.githubusercontent.com/mmilata/znc-otr/master/otr.cpp
echo "Downloading privmsg.cpp"
curl -LO https://raw.githubusercontent.com/kylef/znc-contrib/master/privmsg.cpp
echo "Downloading away_notify.cpp"
curl -LO https://github.com/NuclearW/znc-modules/raw/master/away_notify/away_notify.cpp
echo "Downloading away_notify_unsolicited.cpp"
curl -LO https://github.com/NuclearW/znc-modules/raw/master/away_notify/away_notify_unsolicited.cpp


# ~/.znc/modules
mkdir -p ~/.znc/modules
cd ~/.znc/modules
echo "Downloading push.py"
curl -LO https://raw.githubusercontent.com/jreese/znc-push/python/push.py

echo "You can now run zncconfigure.bash"



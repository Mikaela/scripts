#!/usr/bin/env bash

# Opening the communication apps with a single command without having to
# get them from dmenu so much. Excludes Firefox and Thunderbird as I have
# them inconsistently installed across systems

set -x

# XMPP
if hash dino 2>/dev/null; then
	(dino &)
fi
if hash gajim 2>/dev/null; then
	(gajim &)
else
	(flatpak run org.gajim.Gajim --quiet &)
fi

# Jami, mostly P2P app
if hash jami-gnome 2>/dev/null; then
	(jami-gnome -r &)
fi

# Telegram.org
if [ -f ~/.local/Telegram/Updater ]; then
	(~/.local/Telegram/Updater -many -startintray &)
else
	if hash telegram-desktop 2>/dev/null; then
		(telegram-desktop -many -startintray &)
	fi
fi

# Keybase
if hash run_keybase 2>/dev/null; then
	(run_keybase &)
fi

# Steam
if hash steam 2>/dev/null; then
	(STEAM_FRAME_FORCE_CLOSE=1 steam -silent &)
fi

# Signal
(flatpak run org.signal.Signal --start-in-tray &)

# Microsoft Teams
(flatpak run com.microsoft.Teams &)

# IRC/HexChat
(flatpak run io.github.Hexchat &)

# Matrix
# Elements (previously Riot) perform poorly with this script, use container
# tabs instead or start on-demand.
#(flatpak run im.riot.Riot --profile feneas&)
#(flatpak run im.riot.Riot --profile T2L&)
#(flatpak run im.riot.Riot --profile pirateriot&)

set +x

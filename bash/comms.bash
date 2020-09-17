#!/usr/bin/env bash

# Opening the communication apps with a single command without having to
# get them from dmenu so much. Excludes Firefox and Thunderbird as I have
# them inconsistently installed across systems

set -x

# XMPP
(dino&)
(flatpak run org.gajim.Gajim --quiet&)

# Jami, mostly P2P app
(jami-gnome -r&)

# Telegram.org
(telegram-desktop -many -startintray&)
# 2.2.0+ds-1 has proper multi-account support without extra profiles
#mkdir -p ~/.config/T2L-telegram
#(telegram-desktop -many -workdir ~/.config/T2L-telegram -startintray&)

# Matrix - not in use in favour of Radical
#(flatpak run io.github.NhekoReborn.Nheko&)
#(flatpak run im.riot.Riot --hidden)
#(flatpak run im.riot.Riot --profile T2L --hidden --proxy --proxy-server=127.0.0.1:9119&)

# Keybase
(run_keybase&)

# Steam
(STEAM_FRAME_FORCE_CLOSE=1 steam -silent&)

# WireDesktop - doesn't have --startup due to a bug that it may hide notifications launched that way
# Most of contacts have migrated away and it keeps logging me out so I don't
# care anymore.
#(flatpak run com.wire.WireDesktop&)

# Signal
(flatpak run org.signal.Signal&)
# --start-in-tray seems broken

# Mattermost
# The app is Electron and I would get a better experience if I logged into
# all Mattermost instances in web browser and as their mobile app supports
# only one server at a time (+ another server with beta app), I suggest
# avoiding it
#(flatpak run com.mattermost.Desktop&)

# Microsoft Teams
(flatpak run com.microsoft.Teams&)

set +x

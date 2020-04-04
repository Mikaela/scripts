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
mkdir -p ~/.config/T2L-telegram
(telegram-desktop -many -workdir ~/.config/T2L-telegram -startintray&)

# Matrix - not in use in favour of Radical
#(flatpak run io.github.NhekoReborn.Nheko&)
#(flatpak run im.riot.Riot --hidden)
#(flatpak run im.riot.Riot --profile T2L --hidden --proxy --proxy-server=127.0.0.1:9119&)

# Keybase
(run_keybase&)

# Steam
(STEAM_FRAME_FORCE_CLOSE=1 steam -silent&)
# WireDesktop - doesn't have --startup due to a bug that it may hide notifications launched that way
(flatpak run com.wire.WireDesktop&)

# Signal
(flatpak run org.signal.Signal&)
# --start-in-tray seems broken

set +x

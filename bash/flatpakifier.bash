#!/usr/bin/env bash
# This script partially reverts https://gitea.blesmrt.net/mikaela/scripts/commit/e76a4a6a0d0472428d519205543171b1b1cdc258

export FLATPAKEXPORTS=/var/lib/flatpak/exports/bin
#export TARGETDIR=~/.local/bin
export TARGETDIR=/usr/local/bin

set -x
mkdir -p $TARGETDIR
ln -sfv $FLATPAKEXPORTS/com.rafaelmardojai.Blanket $TARGETDIR/blanket
# `flatpak make-current org.briarproject.Briar stable`?
#ln -sfv $FLATPAKEXPORTS/org.briarproject.Briar $TARGETDIR/briar
ln -sfv $FLATPAKEXPORTS/org.claws_mail.Claws-Mail $TARGETDIR/claws-mail
ln -sfv $FLATPAKEXPORTS/com.github.tchx84.Flatseal $TARGETDIR/flatseal

#ln -sfv $FLATPAKEXPORTS/org.telegram.desktop $TARGETDIR/telegram-desktop
ln -sfv $FLATPAKEXPORTS/org.torproject.torbrowser-launcher $TARGETDIR/torbrowser-launcher-flatpak
ln -sfv $FLATPAKEXPORTS/org.videolan.VLC $TARGETDIR/vlc-flatpak
ln -sfv $FLATPAKEXPORTS/net.davidotek.pupgui2 $TARGETDIR/protonup
ln -sfv $FLATPAKEXPORTS/im.dino.Dino $TARGETDIR/dino

# Electron apps that actually need wrappers and flags
#ln -sfv $FLATPAKEXPORTS/com.visualstudio.code $TARGETDIR/code
#ln -sfv $FLATPAKEXPORTS/com.vscodium.codium $TARGETDIR/codium
#ln -sfv $FLATPAKEXPORTS/chat.delta.desktop $TARGETDIR/deltachat
#ln -sfv $FLATPAKEXPORTS/im.riot.Riot $TARGETDIR/element
#ln -sfv $FLATPAKEXPORTS/chat.schildi.desktop $TARGETDIR/schildichat
#ln -sfv $FLATPAKEXPORTS/org.signal.Signal $TARGETDIR/signal-desktop

set +x

#!/usr/bin/env bash
# This script partially reverts https://gitea.blesmrt.net/mikaela/scripts/commit/e76a4a6a0d0472428d519205543171b1b1cdc258

export FLATPAKEXPORTS=/var/lib/flatpak/exports/bin
export TARGETDIR=~/.local/bin

set -x
ln -sf $FLATPAKEXPORTS/com.rafaelmardojai.Blanket $TARGETDIR/blanket
# `flatpak make-current org.briarproject.Briar stable`?
ln -sf $FLATPAKEXPORTS/org.briarproject.Briar $TARGETDIR/briar
ln -sf $FLATPAKEXPORTS/org.claws_mail.Claws-Mail $TARGETDIR/claws-mail
ln -sf $FLATPAKEXPORTS/com.visualstudio.code $TARGETDIR/code
ln -sf $FLATPAKEXPORTS/com.vscodium.codium $TARGETDIR/codium
ln -sf $FLATPAKEXPORTS/chat.delta.desktop $TARGETDIR/deltachat
ln -sf $FLATPAKEXPORTS/im.riot.Riot $TARGETDIR/element
ln -sf $FLATPAKEXPORTS/com.github.tchx84.Flatseal $TARGETDIR/flatseal
ln -sf $FLATPAKEXPORTS/chat.schildi.desktop $TARGETDIR/schildichat
ln -sf $FLATPAKEXPORTS/org.signal.Signal $TARGETDIR/signal-desktop
ln -sf $FLATPAKEXPORTS/org.telegram.desktop $TARGETDIR/telegram-desktop
ln -sf $FLATPAKEXPORTS/com.github.micahflee.torbrowser-launcher $TARGETDIR/torbrowser-launcher-flatpak
ln -sf $FLATPAKEXPORTS/org.videolan.VLC $TARGETDIR/vlc-flatpak
ln -sf $FLATPAKEXPORTS/net.davidotek.pupgui2 $TARGETDIR/protonup
set +x

#!/usr/bin/env bash
# This script partially reverts https://gitea.blesmrt.net/mikaela/scripts/commit/e76a4a6a0d0472428d519205543171b1b1cdc258
set -x
ln -sf /var/lib/flatpak/exports/bin/com.rafaelmardojai.Blanket ~/.local/bin/blanket
# `flatpak make-current org.briarproject.Briar stable`?
ln -sf /var/lib/flatpak/exports/bin/org.briarproject.Briar ~/.local/bin/briar
ln -sf /var/lib/flatpak/exports/bin/org.claws_mail.Claws-Mail ~/.local/bin/claws-mail
ln -sf /var/lib/flatpak/exports/bin/com.visualstudio.code ~/.local/bin/code
ln -sf /var/lib/flatpak/exports/bin/com.vscodium.codium ~/.local/bin/codium
ln -sf /var/lib/flatpak/exports/bin/chat.delta.desktop ~/.local/bin/deltachat
ln -sf /var/lib/flatpak/exports/bin/im.riot.Riot ~/.local/bin/element
ln -sf /var/lib/flatpak/exports/bin/com.github.tchx84.Flatseal ~/.local/bin/flatseal
ln -sf /var/lib/flatpak/exports/bin/chat.schildi.desktop ~/.local/bin/schildichat
ln -sf /var/lib/flatpak/exports/bin/org.signal.Signal ~/.local/bin/signal-desktop
ln -sf /var/lib/flatpak/exports/bin/org.telegram.desktop ~/.local/bin/telegram-desktop
ln -sf /var/lib/flatpak/exports/bin/com.github.micahflee.torbrowser-launcher ~/.local/bin/torbrowser-launcher-flatpak
ln -sf /var/lib/flatpak/exports/bin/org.videolan.VLC ~/.local/bin/vlc-flatpak
ln -sf /var/lib/flatpak/exports/bin/net.davidotek.pupgui2 ~/.local/bin/protonup
set +x

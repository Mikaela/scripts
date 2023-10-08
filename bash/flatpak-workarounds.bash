#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues

# Reserved directories that cannot be shared
# to flatpaks include at least: /usr

# In case debugging flatpaks is subject to the other restrictions and running
# gdb there is made easier by access to the file. By same logic, they need
# to be able to write to the log.
flatpak override --filesystem=~/.gdbinit:ro --filesystem=~/gdb.txt $@

# Allow read-only access to ~/.curlrc in case a flatpak is utilising curl
# or libcurl starts reading it
flatpak override --filesystem=~/.curlrc:ro $@

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx --talk-name=org.freedesktop.portal.Fcitx $@

# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create $@
flatpak override org.briarproject.Briar --filesystem=~/.java/.userPrefs/org/briarproject/briar:create $@

# This is an ugly hack so I don't have to maintain the config.json separately
# in every profile and can just symlink it
flatpak override im.riot.Riot --filesystem=~/src/gitea.blesmrt.net/Mikaela/gist/matrix/Element:ro $@

# email signature
#flatpak override org.claws_mail.Claws-Mail --filesystem=~/.signature:create $@

# Directory I have normal Nextcloud in
flatpak override com.nextcloud.desktopclient.nextcloud --filesystem=~/Nextcloud:create $@

# PCSX2 files
flatpak override net.pcsx2.PCSX2 --filesystem=~/.config/PCSX2:create $@
flatpak override net.pcsx2.PCSX2 --filesystem=~/PS2:create $@

# A directory I can share between native and flatpak Steam so both have the
# same games without having to navigate weird paths.
flatpak override com.valvesoftware.Steam --filesystem=~/SteamLibrary:create $@
flatpak override net.lutris.Lutris --filesystem=~/SteamLibrary:create $@

# For use with system syncthing, note its flags
flatpak override me.kozec.syncthingtk --filesystem=~/.config/syncthing:create $@

# https://github.com/flathub/com.microsoft.Edge?tab=readme-ov-file#game-controllers-not-working
flatpak override --filesystem=/run/udev:ro com.microsoft.Edge $@

# Just for verbosity. The results can be seen in /var/lib/flatpak/overrides/global
# and /var/lib/flatpak/overrides/<flatpak.id>.
# The user-configurations are ~/.local/share/flatpak/overrides/

flatpak override --show $@
flatpak override --show org.briarproject.Briar $@
flatpak override --show im.riot.Riot $@
#flatpak override --show org.claws_mail.Claws-Mail $@
flatpak override --show com.nextcloud.desktopclient.nextcloud $@
flatpak override --show net.pcsx2.PCSX2 $@
flatpak override --show com.valvesoftware.Steam $@
flatpak override --show net.lutris.Lutris $@
flatpak override --show me.kozec.syncthingtk $@
flatpak override --show com.microsoft.Edge $@$

# Hide commands being executed again
set +x

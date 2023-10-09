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

# Allow ro-access to user-specific fonts
flatpak override --filesystem=~/.local/share/fonts:ro $@

# Text-editors appreciate this
flatpak override --filesystem=~/.editorconfig:ro $@

# Public git repositories I access or symlink much.
# TODO: scripts & text-editors (otherwise nvim and code and codium cannot edit them!)
flatpak override --filesystem=~/.shell-things:ro --filesystem=~/src/gitea.blesmrt.net/Mikaela/shell-things:ro --filesystem=~/src/gitea.blesmrt.net/Mikaela/gist:ro --filesystem=~/src/github.com/Mikaela/mikaela.github.io:ro $@

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx --talk-name=org.freedesktop.portal.Fcitx $@

# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create --filesystem=~/.java/.userPrefs/org/briarproject/briar:create $@

# email signature
#flatpak override org.claws_mail.Claws-Mail --filesystem=~/.signature:create $@

# Directory I have normal Nextcloud in
flatpak override com.nextcloud.desktopclient.nextcloud --filesystem=~/Nextcloud:create $@

# PCSX2 files
flatpak override net.pcsx2.PCSX2 --filesystem=~/.config/PCSX2:create --filesystem=~/PS2:create $@

# A directory I can share between native and flatpak Steam so both have the
# same games without having to navigate weird paths.
flatpak override com.valvesoftware.Steam --filesystem=~/SteamLibrary:create $@
flatpak override net.lutris.Lutris --filesystem=~/SteamLibrary:create $@

# For use with system syncthing, note its flags
flatpak override me.kozec.syncthingtk --filesystem=~/.config/syncthing:create $@

# https://github.com/flathub/com.microsoft.Edge?tab=readme-ov-file#game-controllers-not-working
flatpak override --filesystem=/run/udev:ro com.microsoft.Edge $@

# Display the overrides
if [ -d /var/lib/flatpak/overrides/ ]; then
	tail -n +1 /var/lib/flatpak/overrides/*
fi

if [ -d $HOME/.local/share/flatpak/overrides/ ]; then
	tail -n +1 $HOME/.local/share/flatpak/overrides/*
fi

# Hide commands being executed again
set +x

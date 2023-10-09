#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues

# Reserved directories that cannot be shared
# to flatpaks include at least: /usr

# Overrides for all apps improving Quality of Life
# - debugging with gdb
# - curl configuration following
# - text editor configuration
# - user-specific fonts
flatpak override --filesystem=~/.gdbinit:ro --filesystem=~/gdb.txt:create --filesystem=~/.curlrc:ro --filesystem=~/.editorconfig:ro --filesystem=~/.local/share/fonts:ro $@

# Public git repositories I access or symlink much.
# Must be rw for access by text editors, otherwise they are ro or I will repeat myself
flatpak override --filesystem=~/.shell-things:rw --filesystem=~/src/gitea.blesmrt.net/Mikaela/shell-things:rw --filesystem=~/src/gitea.blesmrt.net/Mikaela/gist:rw --filesystem=~/src/gitea.blesmrt.net/Mikaela/scripts:rw --filesystem=~/src/github.com/Mikaela/mikaela.github.io:rw $@

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx --talk-name=org.freedesktop.portal.Fcitx $@

# Additional SDKs (`flatpak search org.freedesktop.Sdk.Extension`)
flatpak override --env=FLATPAK_ENABLE_SDK_EXT=texlive,dotnet,golang $@

# I don't have other nvim on SteamOS
flatpak override io.neovim.nvim --filesystem=host --filesystem=host-os --filesystem=host-etc $@

# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create --filesystem=~/.java/.userPrefs/org/briarproject/briar:create $@

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

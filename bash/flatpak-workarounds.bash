#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues

# Reserved directories that cannot be shared
# to flatpaks include at least: /usr

# NOTE! Multiple overrides can be set in one command (just pass the --flag
# multiple times), but for the sake of legibility and un/commenting this
# isn't done within this script.

# Overrides for all apps improving Quality of Life
# - debugging with gdb
# - curl configuration following
# - text editor configuration
# - user-specific fonts
flatpak override --filesystem=~/.gdbinit:ro $@
flatpak override --filesystem=~/gdb.txt:rw $@
flatpak override --filesystem=~/.curlrc:ro $@
flatpak override --filesystem=~/.editorconfig:ro $@
flatpak override --filesystem=~/.local/share/fonts:ro $@

# Controller access for everything and SECURITY likely all input access
# F: Not sharing "/dev/uinput" with sandbox: File "/dev/uinput" has unsupported type 0o20000
#flatpak override --filesystem=/dev/uinput:ro $@
flatpak override --filesystem=/run/udev:ro $@
# MangoHUD for everything that has it
flatpak override --env=MANGOHUD=1 $@
flatpak override --filesystem=xdg-config/MangoHud:ro $@

# LaTeX templates allowed before they become an issue.
flatpak override --filesystem=~/texmf/tex/latex/local:ro $@

# Public git repositories I access or symlink much.
flatpak override --filesystem=~/.shell-things:ro $@
flatpak override --filesystem=/root/.shell-things:ro $@
flatpak override --filesystem=~/src/codeberg.org/Aminda/shell-things:ro $@
flatpak override --filesystem=~/src/gitea.blesmrt.net/Mikaela/shell-things:ro $@
flatpak override --filesystem=~/src/gitea.blesmrt.net/Mikaela/gist:ro $@
flatpak override --filesystem=~/src/gitea.blesmrt.net/Mikaela/scripts:ro $@
flatpak override --filesystem=~/src/github.com/Mikaela/mikaela.github.io:ro $@

# EXPERIMENT! All apps may use wayland (sandboxed) and downgrade to
# X11/xwayland only if current desktop doesn't support wayland.
# SECURITY! May let untrusted apps spy on everything on X11 desktops, but
# I either don't have those around or Fedora 40 removes them with the new
# KDE Plasma. NOTE: fallback-x11 has deprecated and overrides x11 socket
# permission.
flatpak override --socket=wayland $@
flatpak override --socket=fallback-x11 $@
flatpak override --nosocket=x11 $@
flatpak override --env=ELECTRON_OZONE_PLATFORM_HINT=auto $@

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx $@
flatpak override --talk-name=org.freedesktop.portal.Fcitx $@
# Darkman automatic theme switching
flatpak override --talk-name=org.freedesktop.impl.portal.desktop.darkman $@

# Additional SDKs (`flatpak search org.freedesktop.Sdk.Extension`)
flatpak override --env=FLATPAK_ENABLE_SDK_EXT=texlive,dotnet,golang $@

# I don't have other nvim on SteamOS
#flatpak override io.neovim.nvim --filesystem=host $@
#flatpak override io.neovim.nvim --filesystem=host-os $@
#flatpak override io.neovim.nvim --filesystem=host-etc $@

# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create $@
flatpak override org.briarproject.Briar --filesystem=~/.java/.userPrefs/org/briarproject/briar:create $@
flatpak override org.briarproject.Briar --nosocket=fallback-x11 $@
flatpak override org.briarproject.Briar --socket=x11 $@

# Directory I have normal Nextcloud in
flatpak override com.nextcloud.desktopclient.nextcloud --filesystem=~/Nextcloud:create $@

# PCSX2 files
flatpak override net.pcsx2.PCSX2 --filesystem=~/.config/PCSX2:create $@
flatpak override net.pcsx2.PCSX2 --filesystem=~/PS2:create $@

# A directory I can share between native and flatpak Steam so both have the
# same games without having to navigate weird paths.
# Heroic and its flatpak also create this
flatpak override com.valvesoftware.Steam --filesystem=~/Games/Heroic:create $@
flatpak override com.valvesoftware.Steam --filesystem=~/SteamLibrary:create $@
flatpak override net.lutris.Lutris --filesystem=~/SteamLibrary:create $@
flatpak override com.heroicgameslauncher.hgl --filesystem=~/SteamLibrary:create $@

# My Steam Deck laziness. My systemd units check for /var/ and Steam checks
# free space based on top level directory so it has to be a subdirectory
# and while the mount point may be /var/sdcard I don't want to give it
# access to root directory in case it denied that for security
if [ -d /var/sdcard/Steam ]; then
	mkdir -vp /var/sdcard/Steam/Library
	flatpak override com.valvesoftware.Steam --filesystem=/var/sdcard/Steam:rw $@
	flatpak override net.lutris.Lutris --filesystem=/var/sdcard/Steam:rw $@
	flatpak override com.heroicgameslauncher.hgl --filesystem=/var/sdcard/Steam:rw $@
	mkdir -vp /var/sdcard/Heroic/Library
	flatpak override com.valvesoftware.Steam --filesystem=/var/sdcard/Heroic:rw $@
	flatpak override net.lutris.Lutris --filesystem=/var/sdcard/Heroic:rw $@
	flatpak override com.heroicgameslauncher.hgl --filesystem=/var/sdcard/Heroic:rw $@
fi

# https://github.com/ValveSoftware/steam-for-linux/issues/4924
# ref: the experiment near top
flatpak override com.valvesoftware.Steam --nosocket=fallback-x11 --socket=x11 $@
flatpak override com.heroicgameslauncher.hgl --nosocket=fallback-x11 --socket=x11 $@

# Steam flatpak workarounds a lot by non-UTF-8 C
flatpak override com.valvesoftware.Steam --env=LC_ALL=C.utf8

# Enable mangohud for all Steam games
#flatpak override com.valvesoftware.Steam --env=MANGOHUD=1 $@

# Permit Steam to access NetworkManager to also fix Big Picture Mode network
flatpak override com.valvesoftware.Steam --system-talk-name=org.freedesktop.NetworkManager $@
# Also power management and console(?) to poweroff from BPM
flatpak override com.valvesoftware.Steam --system-talk-name=org.freedesktop.UPower $@
flatpak override com.valvesoftware.Steam --system-talk-name=org.freedesktop.ConsoleKit $@

# Desktop shortcuts of Steam laziness. Inspired by https://github.com/flathub/com.valvesoftware.Steam/issues/85
flatpak override com.valvesoftware.Steam --filesystem=xdg-desktop:rw $@
flatpak override com.valvesoftware.Steam --filesystem=xdg-data/applications:rw $@
flatpak override com.valvesoftware.Steam --filesystem=xdg-data/icons:rw $@

# Place the wrapper script the desktop entries above expect
# TODO: Be less lazy and don't nest if
if [ "$(id -u)" = "0" ]; then
	mkdir -vp /usr/local/bin/
	if [ -f /var/lib/flatpak/exports/bin/com.valvesoftware.Steam ]; then
		ln -s /var/lib/flatpak/exports/bin/com.valvesoftware.Steam /usr/local/bin/steam
	fi
	if hash symlinks 2> /dev/null; then
		symlinks -d /usr/local/bin/
	fi
fi
if [ -f $HOME/.local/share/flatpak/exports/bin/com.valvesoftware.Steam ]; then
	mkdir -vp $HOME/.local/bin/
	ln -s $HOME/.local/share/flatpak/exports/bin/com.valvesoftware.Steam ~/.local/bin/steam
	if hash symlinks 2> /dev/null; then
		symlinks -d $HOME/.local/bin/
	fi
fi

# For use with system syncthing, note its flags
flatpak override me.kozec.syncthingtk --filesystem=~/.config/syncthing:create $@

# https://github.com/flathub/com.microsoft.Edge?tab=readme-ov-file#game-controllers-not-working
#flatpak override --filesystem=/run/udev:ro com.microsoft.Edge $@

# Mosh starts by opening an SSH connection and thus it needs to at least read my SSH config. Seeing new keys probably needs rw to known_hosts and as I use sockets, they may need rw. Then there is my config.d being in a private git repo...
flatpak override org.mosh.mosh --filesystem=~/.ssh/config:ro $@
flatpak override org.mosh.mosh --filesystem=~/.ssh/config.d:ro $@
flatpak override org.mosh.mosh --filesystem=~/.ssh/known_hosts:rw $@
flatpak override org.mosh.mosh --filesystem=~/.ssh/sockets:rw $@
flatpak override org.mosh.mosh --filesystem=~/src/gitea.blesmrt.net/Mikaela/privgist/ssh/config.d:ro $@

# Apparently Element needs this talk for encrypted search
# https://github.com/flathub/im.riot.Riot/issues/303#issuecomment-1816055123
flatpak override im.riot.Riot --talk-name=org.freedesktop.secrets $@

# Regardless of whether I use the IRC client through Flatpak or Snap,
# it having access to the same config is preferable.
flatpak override org.squidowl.halloy --filesystem=~/snap/halloy:create $@

# Hardening GearLever, https://github.com/mijorus/gearlever/issues/143
flatpak override it.mijorus.gearlever --nofilesystem=host:reset $@
flatpak override it.mijorus.gearlever --filesystem=~/.local/share/applications:create $@
flatpak override it.mijorus.gearlever --filesystem=~/AppImages:create $@

# KDE Connect for web browsers
flatpak override org.mozilla.firefox --talk-name=org.kde.plasma.browser.integration $@
flatpak override org.chromium.Chromium --talk-name=org.kde.plasma.browser.integration $@
flatpak override com.brave.Browser --talk-name=org.kde.plasma.browser.integration $@
flatpak override com.vivaldi.Vivaldi --talk-name=org.kde.plasma.browser.integration $@
flatpak override com.google.Chrome --talk-name=org.kde.plasma.browser.integration $@
flatpak override com.google.ChromeDev --talk-name=org.kde.plasma.browser.integration $@

# Display the overrides
if [ -d /var/lib/flatpak/overrides/ ]; then
	tail -n +1 /var/lib/flatpak/overrides/*
fi

if [ -d $HOME/.local/share/flatpak/overrides/ ]; then
	tail -n +1 $HOME/.local/share/flatpak/overrides/*
fi

# Hide commands being executed again
set +x

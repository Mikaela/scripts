#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues

# Reserved directories that cannot be shared
# to flatpaks include at least: /usr

# NOTE! Multiple overrides can be set in one command (just pass the --flag
# multiple times), but for the sake of legibility and un/commenting this
# isn't done within this script.

# I am lazy
if [ -f flatpakifier.bash ]; then
	(./flatpakifier.bash &)
fi

# Overrides for all apps improving Quality of Life
# - debugging with gdb
# - curl configuration following
# - text editor configuration
# - user-specific fonts
flatpak override --filesystem=~/.gdbinit $@
flatpak override --filesystem=~/gdb.txt:rw $@
flatpak override --filesystem=~/.curlrc $@
flatpak override --filesystem=~/.editorconfig $@
flatpak override --filesystem=~/.local/share/fonts $@
flatpak override --filesystem=xdg-config/fontconfig:ro $@

# Controller access for everything and SECURITY likely all input access
# F: Not sharing "/dev/uinput" with sandbox: File "/dev/uinput" has unsupported type 0o20000
#flatpak override --filesystem=/dev/uinput $@
flatpak override --filesystem=/run/udev $@
# MangoHUD for everything that has it
flatpak override --env=MANGOHUD=1 $@
flatpak override --env=MANGOHUD_CONFIG='read_cfg,background_alpha=0,horizontal,time,time_no_label,time_format=%X,position=bottom-left' $@
flatpak override --filesystem=xdg-config/MangoHud:ro $@
# and of course we are Steam Deck everywhere, no question about it!
flatpak override --env=SteamDeck=1 $@

# LaTeX templates allowed before they become an issue.
flatpak override --filesystem=~/texmf/tex/latex/local $@

# Public git repositories I access or symlink much.
flatpak override --filesystem=~/.shell-things $@
flatpak override --filesystem=/root/.shell-things $@
flatpak override --filesystem=~/src:create $@
flatpak override --filesystem=~/2src:create $@
flatpak override --filesystem=~/src/codeberg.org/Aminda/shell-things $@
flatpak override --filesystem=~/src/gitea.blesmrt.net/Mikaela/shell-things $@
flatpak override --filesystem=~/src/gitea.blesmrt.net/Mikaela/gist $@
flatpak override --filesystem=~/src/gitea.blesmrt.net/Mikaela/scripts $@
flatpak override --filesystem=~/src/github.com/Mikaela/mikaela.github.io $@

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
#flatpak override --env=PROTON_ENABLE_WAYLAND=1 $@
#flatpak override --env=PROTON_ENABLE_HDR=1 $@

# SECURITY! However without these permissions there is crashing outside
# of tmux when attempting to ssh (using gpg authentication subkey) or
# edit files belonging to flatpaks.
#flatpak override page.codeberg.dnkl.foot --socket=ssh-auth $@
#flatpak override page.codeberg.dnkl.foot --socket=gpg-agent $@
#flatpak override page.codeberg.dnkl.foot --filesystem=host $@
#flatpak override page.codeberg.dnkl.foot --filesystem=~/.var/app/page.codeberg.dnkl.foot/config/foot:create $@

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx $@
flatpak override --talk-name=org.freedesktop.portal.Fcitx $@
# Darkman automatic theme switching
flatpak override --talk-name=org.freedesktop.impl.portal.desktop.darkman $@

# Additional SDKs (`flatpak search org.freedesktop.Sdk.Extension`)
flatpak override --env=FLATPAK_ENABLE_SDK_EXT=texlive,dotnet,golang $@

# If timedatectl (systemd) is used, set TZ for flatpaks needing it
if hash timedatectl 2> /dev/null; then
	# DRY - Don't Repeat Yourself
	export TZ=$(timedatectl show --property=Timezone --value)
	# https://github.com/flathub/com.valvesoftware.Steam/wiki#steam-shows-times-with-incorrect-timezone
	flatpak override com.valvesoftware.Steam --env=TZ=$TZ $@
	flatpak override com.valvesoftware.SteamLink --env=TZ=$TZ $@
fi

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
flatpak override com.valvesoftware.Steam --filesystem=xdg-music $@
flatpak override net.lutris.Lutris --filesystem=~/SteamLibrary:create $@
flatpak override com.heroicgameslauncher.hgl --filesystem=~/SteamLibrary:create $@

# Steam's Proton-GE (flatpak). Not supported. Via https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/issues/309#issuecomment-2746256940
# Add /var/lib/flatpak/runtime/com.valvesoftware.Steam.CompatibilityTool.Proton-GE/$(uname -m)/stable/active/files/proton
# as a custom proton
# TODO NOT: don't do this, use the integrated Proton-GE-Latest from WINE
# manager and just don't enable mangohud in GUI (enabled by this script
# already) and keep gamescope/upscaling off and there will not be hooking
# failure message.
#flatpak override com.heroicgameslauncher.hgl --filesystem=/var/lib/flatpak/runtime/com.valvesoftware.Steam.CompatibilityTool.Proton-GE/$(uname -m)/stable $@

# My Steam Deck laziness. My systemd units check for /var/ and Steam checks
# free space based on top level directory so it has to be a subdirectory
# and while the mount point may be /var/sdcard I don't want to give it
# access to root directory in case it denied that for security
flatpak override com.valvesoftware.Steam --filesystem=~/.xlcore:create $@
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
#flatpak override com.valvesoftware.Steam --env=LC_ALL=C.utf8 $@
#flatpak override com.valvesoftware.SteamLink --env=LC_ALL=C.utf8 $@
#flatpak override com.heroicgameslauncher.hgl --env=LC_ALL=C.utf8 $@
flatpak override com.valvesoftware.Steam --env=LC_ALL=en_DK.utf8 $@
flatpak override com.valvesoftware.SteamLink --env=LC_ALL=en_DK.utf8 $@
flatpak override com.heroicgameslauncher.hgl --env=LC_ALL=en_DK.utf8 $@

# pipewire/pulseaudio buffer increase to fix audio issues in proton
# in case of issues outside of proton, set per-game variable empty
flatpak override com.valvesoftware.Steam --env=PULSE_LATENCY_MSEC=60 $@
flatpak override com.valvesoftware.SteamLink --env=PULSE_LATENCY_MSEC=60 $@
flatpak override com.heroicgameslauncher.hgl --env=PULSE_LATENCY_MSEC=60 $@

# Yes, we are SteamDeck, of course
#flatpak override com.valvesoftware.Steam --env=SteamDeck=1 $@

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
		ln -sfv /var/lib/flatpak/exports/bin/com.valvesoftware.Steam /usr/local/bin/steam
	fi
	if hash symlinks 2> /dev/null; then
		symlinks -d /usr/local/bin/
	fi
fi
if [ -f $HOME/.local/share/flatpak/exports/bin/com.valvesoftware.Steam ]; then
	mkdir -vp $HOME/.local/bin/
	ln -sfv $HOME/.local/share/flatpak/exports/bin/com.valvesoftware.Steam ~/.local/bin/steam
	if hash symlinks 2> /dev/null; then
		symlinks -d $HOME/.local/bin/
	fi
	# TODO: This particular workaround doesn't even belong here!
	if [ -d /var/home/aminda/.var/app/com.valvesoftware.Steam/ ]; then
		ln -nsfv /var/home/aminda/.var/app/com.valvesoftware.Steam/.local/share/Steam /home/aminda/.local/share/Steam
		ln -nsfv /var/home/aminda/.var/app/com.valvesoftware.Steam/.steam /home/aminda/.steam
	fi
fi

# For use with system syncthing, note its flags
flatpak override me.kozec.syncthingtk --filesystem=~/.config/syncthing:create $@

# https://github.com/flathub/com.microsoft.Edge?tab=readme-ov-file#game-controllers-not-working
#flatpak override --filesystem=/run/udev com.microsoft.Edge $@

# Mosh starts by opening an SSH connection and thus it needs to at least read my SSH config. Seeing new keys probably needs rw to known_hosts and as I use sockets, they may need rw. Then there is my config.d being in a private git repo...
flatpak override org.mosh.mosh --filesystem=~/.ssh/config $@
flatpak override org.mosh.mosh --filesystem=~/.ssh/config.d $@
flatpak override org.mosh.mosh --filesystem=~/.ssh/known_hosts:rw $@
flatpak override org.mosh.mosh --filesystem=~/.ssh/sockets:rw $@
flatpak override org.mosh.mosh --filesystem=~/src/gitea.blesmrt.net/Mikaela/privgist/ssh/config.d $@

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

# # KDE Connect for web browsers. Just allow it for everything, SECURITY WARNING!
flatpak override --talk-name=org.kde.plasma.browser.integration $@
#flatpak override org.mozilla.firefox --talk-name=org.kde.plasma.browser.integration $@
#flatpak override org.chromium.Chromium --talk-name=org.kde.plasma.browser.integration $@
#flatpak override com.brave.Browser --talk-name=org.kde.plasma.browser.integration $@
#flatpak override com.vivaldi.Vivaldi --talk-name=org.kde.plasma.browser.integration $@
#flatpak override com.google.Chrome --talk-name=org.kde.plasma.browser.integration $@
#flatpak override com.google.ChromeDev --talk-name=org.kde.plasma.browser.integration $@

# qBittorrent
flatpak override org.qbittorrent.qBittorrent --filesystem=~/bt:create $@
ln -nsfv ~/bt ~/.bt
flatpak override org.qbittorrent.qBittorrent --filesystem=xdg-download $@

# Explicitly allow what Calibre needs
flatpak override com.calibre_ebook.calibre --nofilesystem=host $@
flatpak override com.calibre_ebook.calibre --nodevice=all $@
flatpak override com.calibre_ebook.calibre --device=dri $@
flatpak override com.calibre_ebook.calibre --filesystem=/run/media $@
# FanFicFare Browser Cache. TODO: Firefox flatpak and other browsers
flatpak override com.calibre_ebook.calibre --filesystem=~/.cache/mozilla/firefox/ $@
flatpak override com.calibre_ebook.calibre --filesystem=~/.cache/vivaldi/ $@
flatpak override com.calibre_ebook.calibre --filesystem=~/.cache/vivaldi-snapshot/ $@
flatpak override com.calibre_ebook.calibre --filesystem=~/Calibre\ Library:create $@
flatpak override com.calibre_ebook.calibre --filesystem=~/bt $@
flatpak override com.calibre_ebook.calibre --filesystem=~/xdg-download $@
# Simplicity and so it won't attempt to create a directory in different locale
#flatpak override com.calibre_ebook.calibre --env=LC_ALL=C.utf8 $@
flatpak override com.calibre_ebook.calibre --env=LC_ALL=en_DK.utf8 $@

# yt-dlp config file
flatpak override io.mpv.Mpv --filesystem=~/.config/yt-dlp/config:ro $@

# Display the overrides
if [ -d /var/lib/flatpak/overrides/ ]; then
	tail -n +1 /var/lib/flatpak/overrides/*
fi

if [ -d $HOME/.local/share/flatpak/overrides/ ]; then
	tail -n +1 $HOME/.local/share/flatpak/overrides/*
fi

# Hide commands being executed again
set +x

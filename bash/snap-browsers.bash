#!/usr/bin/env bash
set -x
# I am not a fan of Snap in general due to issues such as one allowed
# repository allowed at a time, closed source server, issues when running
# without a desktop environment, but with web browsers it beats flatpak for
# respecting browser policies, thus this script which is kind of
# snap-workarounds.bash

# WARNING: No KDE Desktop Integration for snap users. And obviously this
# script isn't going to install snap duplicates of browsers that are already
# installed, Ubuntu users are trusted to know firefox/chromium are wrappers
# for snaps.

# If snap isn't installed, exit
if ! hash snap 2> /dev/null; then
	echo "This script is useless without snap installed."
	exit 1
fi

# Require root or exit
if [ "$(id -u)" != "0" ]; then
	echo "This script requires root." 1>&2
	exit 1
fi

# Ensure classic snap support is enabled
if [ ! -d "/snap" ]; then
	ln -nsv /var/lib/snapd/snap /snap
fi

# Init policy directories or quit if the script isn't available
if [ -f "../submodules/shell-things/etc/init-browser-policies.bash" ]; then
	# TODO: That script has comments that might be more at home here!
	../submodules/shell-things/etc/init-browser-policies.bash
else
	echo "Missing submodule shell-things, initializing submodules"
	git submodule update --init
	echo "Please run the script again!"
	exit 1
fi

# If Firefox is already installed, switch to the ESR channel for distrust
# towards Mozilla and search engine policy support. Otherwise install Firefox
# This is officially supported/published by Mozilla.
if [[ ! -f "/usr/bin/firefox" ]] && [[ ! -f "/usr/bin/firefox-esr" ]]; then
	if [ -f "/snap/bin/firefox" ]; then
		snap refresh firefox --channel=esr/stable
	else
		snap install firefox --channel=esr/stable
	fi
else
	echo "If on Ubuntu: sudo snap refresh firefox --channel=esr/stable"
fi

# Difficult to test Chromium policies without Chromium. And for testing edge is fine.
# Published/supported by Canonical.
if [[ ! -f "/usr/bin/chromium" ]] && [[ ! -f "/usr/bin/chromium-browser" ]]; then
	if [ -f "/snap/bin/chromium" ]; then
		snap refresh chromium --channel=edge
	else
		snap install chromium --edge
	fi
else
	echo "If on Ubuntu: sudo snap refresh chromium --channel=edge"
fi

# European/Norwegian freeware browser that I prefer to keep installed as an option.
# Official snap.
if [[ ! -f "/usr/bin/vivaldi" ]] && [[ ! -f "/usr/bin/vivaldi-snapshot" ]]; then
	if [ -f "/snap/bin/vivaldi.vivaldi-stable" ]; then
		snap refresh vivaldi
	else
		snap install vivaldi
	fi
fi

set +x

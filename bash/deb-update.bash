#!/usr/bin/env bash

# A simple script for updating all package managers simultaneously

# Show commands being executed
set -x

# This is said to be a poor practice that should only be used for debugging
export LC_ALL=C.utf8

# if hash checks that the command exists
if hash apt-get 2> /dev/null; then
	# I am not sure if -y here even does anything, at least it won't work for
	# accepting suite changes for Debian when testing becomes stable.
	# Checking for updates or new packages.
	apt-get -y update

	# potentially unsafe first time, so there hopefully is space for new kernels
	apt-get "$@" autoremove

	# If arguments like -y are passed to the script, they become "$@"
	apt-get "$@" upgrade --with-new-pkgs

	# potentially unsafe, second time after new kernel is installed
	apt-get "$@" autoremove
fi

if hash dpkg 2> /dev/null; then
	# In case dpkg was interrupted previously, configure packages.
	dpkg --configure -a
fi

# Enables Fedora third party repositories if not enabled, otherwise quiet.
# My systems most likely have them already
if hash fedora-third-party 2> /dev/null; then
	systemctl enable fedora-third-party-refresh.service
	fedora-third-party enable
	# Are they enabled?
	fedora-third-party query
fi

# If we have a /sysroot/ostree chances are we are on Fedora Atomic and
# should use rpm-ostree instead of dnf
if [[ -f /usr/bin/dnf && ! -d /sysroot/ostree ]]; then
	# I don't know if -y does anything here either and I think this may be
	# useless, but I am used to it coming from apt and I think it will just
	# say nothing to do or do nothing if mirrors haven't updated.
	dnf check-update -y

	# potentially unsafe first time, I am not sure if this is concern outside of Debian/Ubuntu though
	dnf "$@" autoremove

	# If arguments like -y are passed to the script, they become "$@"
	#dnf "$@" upgrade

	# Doing check-update and upgrade together seems to be necessary for
	# Chromium based browsers and their repositories :shrug:
	dnf "$@" upgrade --refresh

	# potentially unsafe, see a few lines above and the apt-get section
	dnf "$@" autoremove
fi

# Arch Linux package management
if hash pacman 2> /dev/null; then
	pacman -Syu

	# weekly cache cleanup service
	if hash paccache 2> /dev/null; then
		systemctl enable paccache.timer
	fi
fi

# https://github.com/Homebrew/brew
if [[ -f /etc/systemd/system/linuxbrew-update.timer && $(id -u) == 0 ]]; then
	if hash systemctl 2> /dev/null; then
		systemctl enable linuxbrew-update.timer
		systemctl start linuxbrew-update.service
		# Technically this should be first, but it's probably rarer than my
		# above unit and I am yet to experience issues anyway.
		if [[ -f /etc/systemd/system/linuxbrew-permissions.timer ]]; then
			systemctl enable linuxbrew-permissions.timer
			systemctl start linuxbrew-permissions.service
		fi
	fi
elif [[ -d /home/linuxbrew/.linuxbrew/bin && $(id -u) != 0 ]]; then
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	export HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar
	export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
	export HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew
	if [[ -f /home/linuxbrew/.linuxbrew/bin/brew2 ]]; then
		/home/linuxbrew/.linuxbrew/bin/brew2 doctor
		/home/linuxbrew/.linuxbrew/bin/brew2 update --quiet
		/home/linuxbrew/.linuxbrew/bin/brew2 upgrade --quiet
	else
		/home/linuxbrew/.linuxbrew/bin/brew doctor
		/home/linuxbrew/.linuxbrew/bin/brew update --quiet
		/home/linuxbrew/.linuxbrew/bin/brew upgrade --quiet
	fi
else
	printf "Either linuxbrew is not installed or running as root, skipping linuxbrew...\n"
fi

if hash pipx 2> /dev/null; then
	if [[ $(id -u) != 0 ]]; then
		pipx upgrade-all
	fi
fi

if hash rpmconf 2> /dev/null; then
	# Tests if there are rpmsave/rpmnew files, hopefully is non-interactive
	rpmconf -a -t
fi

if hash flatpak 2> /dev/null; then
	# Flatpak apps are sandboxed and should be safe to update automatically
	# KEEP --noninteractive IN PLACE! While it removes progress bar, it also
	# doesn't blink making it worth it in case of migraine attack.
	flatpak update --noninteractive --assumeyes
	flatpak update --noninteractive --assumeyes --no-static-deltas
	# Note to self
	echo '!!! In case of weird errors e.g. while trying to checkout, try running: flatpak repair'
	#echo '	  404 is not a weird error, try flatpak <subcommand> --no-static-deltas'
	# Flatpak's version of `apt autoremove`
	flatpak uninstall --unused --assumeyes --noninteractive
	# And as an user although probably inapplicable for sudo/root
	flatpak update --user --noninteractive --assumeyes
	flatpak update --user --noninteractive --assumeyes --no-static-deltas
	flatpak uninstall --user --unused --assumeyes --noninteractive

	# Actually enable my flatpak timer too, just like homebrew above
	if [[ -f "/etc/systemd/system/flatpak-update.timer" && $(id -u) == 0 ]]; then
		if hash systemctl 2> /dev/null; then
			systemctl enable --now flatpak-update.timer
		fi
	fi
fi

if hash snap 2> /dev/null; then
	# I don't want my systems full of old snaps
	# > retain must be a number between 2 and 20, not "1"
	snap set system refresh.retain=2
	# Snap packages auto-update anyway though, but I like checking them while
	# doing everything else too
	snap refresh
	# so I may have some sort of an idea when snap packages have been updated
	# if they have auto-refreshed
	snap changes
fi
# I don't have flatpak or snap going to background, because I often do
# ./deb-update.bash && poweroff

if hash pkcon 2> /dev/null; then
	# KDE Plasma uses PackageKit for the update indicator
	pkcon backend-details --noninteractive --plain --verbose
	pkcon refresh --noninteractive --plain --verbose
	(pkcon get-updates --noninteractive --plain --verbose &)
	(pkcon get-distro-upgrades --noninteractive --plain --verbose &)
	pkcon update --noninteractive --plain --verbose
fi

if hash apt-file 2> /dev/null; then
	# So the local apt-file database is up-to-date.
	apt-file update
fi

if hash needrestart 2> /dev/null; then
	# needrestart batch mode, should be visible on bottom of scrollback
	# see https://github.com/liske/needrestart/blob/master/README.batch.md
	needrestart -b
	# Give me a moment to see what needrestart says even if I pipe or enter
	# multiple commands at once!
	sleep 5
fi

# archlinux-contrib
if hash checkservices 2> /dev/null; then
	checkservices
	sleep 5
fi

if [[ -f /usr/bin/rpm-ostree && -d /sysroot/ostree ]]; then
	# The verb update is used instead of documented upgrade for KDE Plasma
	# Discover compatibility and avoiding redundancy.
	#rpm-ostree upgrade --check
	rpm-ostree update --check
	rpm-ostree status -v
	sleep 5
	#rpm-ostree upgrade
	rpm-ostree update
	sleep 5
	rpm-ostree status -v
	sleep 5
	if hash systemctl 2> /dev/null; then
		systemctl enable rpm-ostreed-automatic.timer
	fi
fi

# Hide commands being executed again
set +x

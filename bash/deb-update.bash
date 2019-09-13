#!/usr/bin/env bash

# A simple script for updating all package managers simultaneously

# Show commands being executed
set -x

# I am not sure if -y here even does anything, at least it won't work for
# accepting suite changes for Debian when testing becomes stable.
# Checking for updates or new packages.
apt-get -y update

# If arguments like -y are passed to the script, they become "$@"
apt-get "$@" upgrade --with-new-pkgs

# Flatpak apps are sandboxed and should be safe to update automatically
flatpak update --assumeyes --noninteractive
# Flatpak's version of `apt autoremove`
#flatpak uninstall --unused

# Snap packages auto-update anyway though, but I like checking them while
# doing everything else too
snap refresh
# so I may have some sort of an idea when snap packages have been updated
# if they have auto-refreshed
snap changes

# So the local apt-file database is up-to-date.
apt-file update

# I don't have flatpak or snap going to background, because I often do
# ./deb-update.bash && poweroff

# Hide commands being executed again
set +x

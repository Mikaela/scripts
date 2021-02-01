#!/usr/bin/env bash

# A simple script for updating all package managers simultaneously

# Show commands being executed
set -x

# if hash checks that the command exists
if hash apt-get 2>/dev/null; then
    # I am not sure if -y here even does anything, at least it won't work for
    # accepting suite changes for Debian when testing becomes stable.
    # Checking for updates or new packages.
    apt-get -y update

    # If arguments like -y are passed to the script, they become "$@"
    apt-get "$@" upgrade --with-new-pkgs

    # potentially unsafe
    apt-get "$@" autoremove
fi

if hash dnf 2>/dev/null; then
    # I don't know if -y does anything here either and I think this may be
    # useless, but I am used to it coming from apt and I think it will just
    # say nothing to do or do nothing if mirrors haven't updated.
    dnf check-update -y

    # If arguments like -y are passed to the script, they become "$@"
    dnf "$@" upgrade
fi

if hash flatpak 2>/dev/null; then
    # Flatpak apps are sandboxed and should be safe to update automatically
    flatpak update --assumeyes
    # Flatpak's version of `apt autoremove`
    flatpak uninstall --unused --assumeyes
fi

if hash snap 2>/dev/null; then
    # Snap packages auto-update anyway though, but I like checking them while
    # doing everything else too
    snap refresh
    # so I may have some sort of an idea when snap packages have been updated
    # if they have auto-refreshed
    snap changes
fi

if hash apt-file 2>/dev/null; then
    # So the local apt-file database is up-to-date.
    apt-file update
fi

# I don't have flatpak or snap going to background, because I often do
# ./deb-update.bash && poweroff

# Hide commands being executed again
set +x

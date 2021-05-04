#!/usr/bin/env bash

# Show commands being executed
set -x

# So I don't have to remember these of wonder why my systems have different
# set of remotes and are missing something existing on another
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak remote-add --if-not-exists kdeapps https://distribute.kde.org/kdeapps.flatpakrepo

# Hide commands being executed again
set +x
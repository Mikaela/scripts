#!/usr/bin/env bash

# Show commands being executed
set -x

# So I don't have to remember these of wonder why my systems have different
# set of remotes and are missing something existing on another
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak remote-add --if-not-exists kdeapps https://distribute.kde.org/kdeapps.flatpakrepo
flatpak remote-add --if-not-exists nheko-nightly https://nheko.im/nheko-reborn/nheko/-/raw/master/nheko-nightly.flatpakrepo

# As I cannot find a .flatpakrepo
flatpak install https://ftp.gajim.org/flatpak/appstream/org.gajim.Gajim.Devel.flatpakref

# Fedora?
flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org
flatpak remote-add --if-not-exists fedora-testing oci+https://registry.fedoraproject.org#testing
# the previous command does nothing on Fedora as it already exists, but it still
# needs to be enabled
flatpak remote-modify --enable fedora-testing

# Hide commands being executed again
set +x

#!/usr/bin/env bash

# Show commands being executed
set -x

# So I don't have to remember these of wonder why my systems have different
# set of remotes and are missing something existing on another
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo $@
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo $@
flatpak remote-add --if-not-exists kdeapps https://distribute.kde.org/kdeapps.flatpakrepo $@
flatpak remote-add --if-not-exists nheko-nightly https://nheko.im/nheko-reborn/nheko/-/raw/master/nheko-nightly.flatpakrepo $@

# Fedora?
flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org $@
flatpak remote-add --if-not-exists fedora-testing oci+https://registry.fedoraproject.org#testing $@

# Unable to find .flatpakrepos, keep below actual repos.
#flatpak install https://ftp.gajim.org/flatpak/appstream/org.gajim.Gajim.Devel.flatpakref $@ &

# the previous command does nothing on Fedora as it already exists, but it still
# needs to be enabled
flatpak remote-modify --enable fedora-testing $@
# In case of similar issues on other distributions
flatpak remote-modify --enable flathub $@
flatpak remote-modify --enable flathub-beta $@
flatpak remote-modify --enable kdeapps $@
# The other repositories are very unlikely to ship by default with anything

# Hide commands being executed again
set +x

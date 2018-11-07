#!/usr/bin/env bash
set -x
apt-get -y update
apt-get "$@" upgrade --with-new-pkgs
flatpak update --assumeyes
snap refresh
snap changes
set +x

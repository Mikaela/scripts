#!/usr/bin/env bash
set -x
apt-get -y update
apt-get "$@" upgrade
flatpak update --assumeyes
snap refresh
set +x

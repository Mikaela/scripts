#!/usr/bin/env bash
set -x

# This is yet another script to enable my laziness.
flatpak install --or-update https://cdn.kde.org/flatpak/kde-runtime-nightly/org.kde.Platform.flatpakref $@
#flatpak install --or-update https://cdn.kde.org/flatpak/kate-nightly/org.kde.kate.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/haruna-nightly/org.kde.haruna.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/audiotube-nightly/org.kde.audiotube.flatpakref
set +x

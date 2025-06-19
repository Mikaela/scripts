#!/usr/bin/env bash
set -x

# This is yet another script to enable my laziness.
flatpak install --or-update https://cdn.kde.org/flatpak/kde-runtime-nightly/org.kde.Platform.flatpakref $@
#flatpak install --or-update https://cdn.kde.org/flatpak/kate-nightly/org.kde.kate.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/haruna-nightly/org.kde.haruna.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/audiotube-nightly/org.kde.audiotube.flatpakref
flatpak install --or-update https://cdn.kde.org/flatpak/neochat-nightly/org.kde.neochat.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/plasmatube-nightly/org.kde.plasmatube.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/kteatime-nightly/org.kde.kteatime.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/konversation-nightly/org.kde.konversation.flatpakref $@

set +x

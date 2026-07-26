#!/usr/bin/env bash
set -x

# This is yet another script to enable my laziness.
# App list: https://origin.cdn.kde.org/flatpak/
flatpak install --or-update https://cdn.kde.org/flatpak/kde-runtime-nightly/org.kde.Platform.flatpakref $@
#flatpak install --or-update https://cdn.kde.org/flatpak/kate-nightly/org.kde.kate.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/haruna-nightly/org.kde.haruna.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/audiotube-nightly/org.kde.audiotube.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/neochat-nightly/org.kde.neochat.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/plasmatube-nightly/org.kde.plasmatube.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/kteatime-nightly/org.kde.kteatime.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/konversation-nightly/org.kde.konversation.flatpakref $@
flatpak install --or-update https://cdn.kde.org/flatpak/kpublicalerts-nightly/org.kde.publicalerts.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/itinerary-nightly/org.kde.itinerary.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/kclock-nightly/org.kde.kclock.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/kcolorchooser-nightly/org.kde.kcolorchooser.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/kcharselect-nightly/org.kde.kcharselect.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/kteatime-nightly/org.kde.kteatime.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/ktimetracker-nightly/org.kde.ktimetracker.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/kweather-nightly/org.kde.kweather.flatpakref $@
flatpak install --or-update https://origin.cdn.kde.org/flatpak/plasma-camera-nightly/org.kde.plasma-camera.flatpakref $@

set +x

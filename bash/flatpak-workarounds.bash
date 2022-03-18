#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues

# Allowing system themes in flatpaks
flatpak override --filesystem=/usr/share/themes:ro --filesystem=~/.themes:ro
flatpak override --filesystem=/usr/share/icons:ro --filesystem=~/.icons:ro
flatpak override --filesystem=/usr/share/cursors:ro --filesystem=~/.cursors:ro

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx --talk-name=org.freedesktop.portal.Fcitx

# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create
flatpak override org.briarproject.Briar --filesystem=~/.java/.userPrefs/org/briarproject/briar:create

# Just for verbosity
flatpak override --show
flatpak override --show org.briarproject.Briar

# Hide commands being executed again
set +x

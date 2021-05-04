#!/usr/bin/env bash

# Show commands being executed
set -x

# resutls in /var/lib/flatpak/overrides/global
flatpak override --filesystem=/usr/share/themes:ro --filesystem=~/.themes:ro
flatpak override --filesystem=/usr/share/icons:ro --filesystem=~/.icons:ro
flatpak override --filesystem=/usr/share/cursors:ro --filesystem=~/.cursors:ro

# Hide commands being executed again
set +x
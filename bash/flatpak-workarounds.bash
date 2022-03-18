#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues
# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create
flatpak override org.briarproject.Briar --filesystem=~/.java/.userPrefs/org/briarproject/briar:create

# Just for verbosity
flatpak override --show
flatpak override --show org.briarproject.Briar

# Hide commands being executed again
set +x

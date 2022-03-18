#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues
# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override --user org.briarproject.Briar --filesystem=~/.briar:create
flatpak override --user org.briarproject.Briar --filesystem=~/.java/.userPrefs/org/briarproject/briar:create

# Hide commands being executed again
set +x

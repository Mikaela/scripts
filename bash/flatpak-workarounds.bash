#!/usr/bin/env bash

# Show commands being executed
set -x

# Workarounds for common flatpak app issues

# Let's begin by checking remotes and installing what this touches…
#flatpak update --appstream
#flatpak install --assumeyes flathub org.briarproject.Briar im.riot.Riot com.nextcloud.desktopclient.nextcloud

# Allowing system themes in flatpaks
flatpak override --filesystem=/usr/local/share/themes:ro --filesystem=/usr/share/themes:ro --filesystem=~/.themes:ro
flatpak override --filesystem=/usr/local/share/icons:ro --filesystem=/usr/share/icons:ro --filesystem=~/.icons:ro
flatpak override --filesystem=/usr/local/share/cursors:ro --filesystem=/usr/share/cursors:ro --filesystem=~/.cursors:ro

# In case debugging flatpaks is subject to the other restrictions and running
# gdb there is made easier by access to the file. By same logic, they need
# to be able to write to the log.
flatpak override --filesystem=~/.gdbinit:ro --filesystem=~/gdb.txt

# Backticks and a lot of common characters in all Flatpaks
# https://github.com/flatpak/flatpak/issues/2031
flatpak override --talk-name=org.fcitx.Fcitx --talk-name=org.freedesktop.portal.Fcitx

# https://github.com/flathub/org.briarproject.Briar/issues/5
flatpak override org.briarproject.Briar --filesystem=~/.briar:create
flatpak override org.briarproject.Briar --filesystem=~/.java/.userPrefs/org/briarproject/briar:create

# This is an ugly hack so I don't have to maintain the config.json separately
# in every profile and can just symlink it
flatpak override im.riot.Riot --filesystem=~/src/gitea.blesmrt.net/Mikaela/gist/matrix/Element:ro

# email signature
#flatpak override org.claws_mail.Claws-Mail --filesystem=~/.signature:create

# Directory I have normal Nextcloud in
flatpak override com.nextcloud.desktopclient.nextcloud --filesystem=~/Nextcloud:create

# PCSX2 files
flatpak override net.pcsx2.PCSX2 --filesystem=~/.config/PCSX2/

# Just for verbosity. The results can be seen in /var/lib/flatpak/overrides/global …
flatpak override --show
# …and /var/lib/flatpak/overrides/org.briarproject.Briar
flatpak override --show org.briarproject.Briar
# do I need to list those?
flatpak override --show im.riot.Riot
#flatpak override --show org.claws_mail.Claws-Mail
flatpak override --show com.nextcloud.desktopclient.nextcloud
flatpak override --show net.pcsx2.PCSX2

# Hide commands being executed again
set +x

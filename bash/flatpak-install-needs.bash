#!/usr/bin/env bash
set -x

# This is yet another script to enable my laziness.

# These will be expected and it calls the KDE nightly apps as well
if [ -f ./flatpak-add-remotes.bash ]; then
	sleep 3
	./flatpak-add-remotes.bash
else
	echo "Missing remote adding script."
	exit 1
fi

# Functions enable me to be even more lazy
_flatpak-install() {
	flatpak install --or-update --assumeyes --noninteractive $@
}

# Remember! These are installed from KDE Nightly apps already!
# Haruna, NeoChat, Konversations, Itinerary, KColorChooser, KCharSelect, KTimeTracker, KWeather, Plasma-Camera

# Lazy conditional. If outside of flatpak, not necessary, otherwise necessary
if [[ ! -f /usr/share/applications/org.torproject.torbrowser-launcher.desktop ]]; then
	_flatpak-install flathub org.torproject.torbrowser-launcher
fi

# In case I have override removed the system Firefox, ensure there is at least one global
if [[ ! -f /usr/bin/firefox ]]; then
	#_flatpak-install flathub org.mozilla.firefox
	_flatpak-install flathub-beta org.mozilla.firefox//beta
fi

# Alarms
echo "Alarms: KClock, PublicAlerts and KTeaTime are already installed through nightly apps."
sleep 3

# Communication
_flatpak-install flathub im.dino.Dino org.gajim.Gajim org.jitsi.jitsi-meet org.signal.Signal org.telegram.desktop
_flatpak-install nheko-nightly im.nheko.Nheko
# My goal for mumble is to be part of the system, but not always possible
if [[ ! -f /usr/bin/mumble ]]; then
	_flatpak-install flathub info.mumble.Mumble
fi

# Gayming
echo "Gayming: on gayming systems you know what to install."
sleep 3

# General
echo "Remember com.nextcloud.desktopclient.nextcloud on 'work' systems"
sleep 3
_flatpak-install flathub com.calibre_ebook.calibre com.github.wwmm.easyeffects com.rafaelmardojai.Blanket de.haeckerfelix.Shortwave me.kozec.syncthingtk org.fedoraproject.MediaWriter org.gnome.eog org.kde.elisa org.kde.kate org.kde.kcalc org.kde.kolourpaint org.kde.krdc org.pulseaudio.pavucontrol org.kde.okular org.qbittorrent.qBittorrent

# Office
_flatpak-install flathub org.kde.skanpage org.libreoffice.LibreOffice org.libreoffice.LibreOffice.BundledExtension.Voikko org.gnome.glabels-3

# YouTube
echo "YouTube: likely through Firefox & uBlock Origin or already installed through nightlies"
sleep 3

# Final cleanup and reminders
flatpak uninstall --unused --assumeyes --noninteractive
echo "Remember https://aminda.eu/n/essentialsoftware and that these should be in sync for actually necessary applications!"
sleep 3

if [ -f ./flatpakifier.bash ]; then
	echo "Helpful symlinks if not CTRL-C..."
	sleep 15
	./flatpakifier.bash
fi

set +x

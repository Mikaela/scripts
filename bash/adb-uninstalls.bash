#!/usr/bin/env bash

# This script enables DoT with adblocking by DNS4EU and uninstalls questionable Android components
# - Android Safety Core which observes what images you have (CSAM filter for ChatControl aka mass surveillance)
# - Google Gemini which otherwise has access to all other apps and processes your Signal messages in the cloud
# - Google search which needs to be reinstalled before Android Auto for Finnish voice commands (https://www.youtube.com/watch?v=jXEqNDaJJ00)
# - Android Auto which needs to be reinstalled after Google. See previous comment.

# adb global options:
# -a	listen on all network interfaces, not just localhost
# -d	use USB device (error if multiple devices connected)

set -x

if ! hash adb 2> /dev/null; then
	echo "Error: adb not found in $PATH" 1>&2
	exit 1
fi

# Remember,
echo "In case of trouble check Android System Settings, Connected devices, USB mode. It should be data transfer for adb USB debugging to take effect."

# Enable DNS-over-TLS
(adb "$@" shell settings put global private_dns_mode hostname &)
(adb "$@" shell settings put global private_dns_specifier noads.joindns4.eu &)

# Uninstall or disable Android Safety Core (suspected chatcontrol backdoor)
(adb "$@" shell pm uninstall com.google.android.safetycore &)
#(adb "$@" shell pm disable com.google.android.safetycore &)
# Uninstall or disable Gemini so it won't access other apps
(adb "$@" shell pm uninstall com.google.android.apps.bard &)
#(adb "$@" shell pm disable com.google.android.apps.bard &)

# Keep last! Weird workaround for Finnish language in Android Auto audio input https://www.youtube.com/watch?v=jXEqNDaJJ00
(adb "$@" shell pm uninstall com.google.android.googlequicksearchbox &)
#(adb "$@" shell pm disable com.google.android.googlequicksearchbox &)
(adb "$@" shell pm uninstall com.google.android.projection.gearhead &)
#(adb "$@" shell pm disable com.google.android.projection.gearhead &)

# Wait a bit and then reboot the device
echo "You may want to reinstall Google first and Android Auto after it."
echo "https://play.google.com/store/apps/details?id=com.google.android.googlequicksearchbox"
echo "https://play.google.com/store/apps/details?id=com.google.android.projection.gearhead"
echo "Remember to not allow Android Auto to adjust system settings!"

sleep 15
echo "Please execute \"adb $@ reboot\" once finished."

set +x

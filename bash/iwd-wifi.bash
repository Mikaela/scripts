#!/usr/bin/env bash

# A simple script to list networks iwd detects and give instruction for
# connecting to it. Heavily inspired by `man iwctl`

# So the terminal is empty for the table
clear

# `iwctl device list` gives the WiFi adapters
WIFIDEVICE=wlan0

# Scan and list results
iwctl station $WIFIDEVICE scan
iwctl station $WIFIDEVICE get-networks

# Print the command to connect. Replace $KEY and $SSID with the actual ones
# The manpage says: iwctl --passphrase=PASSPHRASE station DEVICE connect SSID
# but considering it says -P is shorthand for passphrase, I think this should
# work too while being more logical in my opinion.
echo "To connect:
% iwctl station $WIFIDEVICE connect \$SSID -P \$KEY
"
# For permanent connections https://gitea.blesmrt.net/mikaela/shell-things/src/branch/master/var/lib/iwd

# Device Provisioning Protocol https://iwd.wiki.kernel.org/device_provisioning
# requires qrencode, so let's check it exists
if hash qrencode needrestart 2>/dev/null; then
    # Remind of command to share
    echo "To share credentials:
% iwctl dpp $WIFIDEVICE start-configurator
"
    # It needs to be stopped too
    echo "To stop sharing credentials:
% iwctl dpp $WIFIDEVICE stop"
# Remind me that this part exists if qrencode is not found.
else
    echo "WARNING! qrencode not found."
fi

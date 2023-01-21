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
echo "% sudo iwctl --passphrase=\$KEY station $WIFIDEVICE connect \$SSID"

# For permanent connections https://gitea.blesmrt.net/mikaela/shell-things/src/branch/master/var/lib/iwd

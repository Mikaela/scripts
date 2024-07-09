#!/usr/bin/env bash

# Argument: SSID

# -l H uses the highest error correction in case 30 % gets damaged (or artistried upon)

PIXELSIZE=6

# Outputs QR code to terminal
qrencode -l H -t utf8 "WIFI:T:nopass;S:$1;;"
# Stores QR code as SSID.png, -s doubles pixel size from default 3
qrencode -l H -s $PIXELSIZE -o $1.png "WIFI:T:nopass;S:$1;;"
# Might as well jpg this too
magick "$1".png "$1".jpg

# Prints details
echo "SSID: $1"
echo "Stored as $1.png"

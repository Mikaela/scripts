#!/usr/bin/env bash

# Arguments: Name & content

# -l H uses the highest error correction in case 30 % gets damaged (or artistried upon)

# Outputs QR code to terminal

# ${@:2} takes all arguments except not the first one
qrencode -l H -t utf8 "${@:2}"
# Stores QR code as $1.png (first argument)
qrencode -l H -o "$1".png "${@:2}"
# My stepfather wants jpg
convert "$1".png "$1".jpg
# Prints details
echo "Name: $1.png"
echo "Content: ${@:2}"

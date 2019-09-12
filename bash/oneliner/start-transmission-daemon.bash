#!/usr/bin/env bash

# A simple script to start Transmission-daemon with a reasonable config
# flags, which are mostly self-explanatory so I won't bother documenting

transmission-daemon "$@" --encryption-required --dht --utp --paused

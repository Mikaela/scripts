#!/usr/bin/env bash

# Get the number of torrents, begins from 2 (1 is header line), the last
# line is SUM.
TORRENTS=$(transmission-remote -l|wc -l)
CURRENT=1

# until $CURRENT equals $TORRENTS ?
until [ $CURRENT -gt $TORRENTS ]
    do
    # get the information for $CURRENT? Grep the magnet line and cut out the
    # frist field ("Magnet: ") using awk?
    transmission-remote -l -t $CURRENT -i | grep -i magnet | awk -F': ' '{print $2}'
    # increase $CURRENT
    ((CURRENT++))
done

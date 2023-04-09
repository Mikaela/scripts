#!/usr/bin/env bash

# Based on https://gist.github.com/turt2live/a99c8e794d6115d4ddfaadb72aabf063

# Refer to https://spec.matrix.org/unstable/rooms/#complete-list-of-room-versions
# and room versions supported by your homeserver BEFORE adjusting/running this.
# Otherwise the target room version may be outdated or the last one I have
# ran this script for.
ROOMVERSION=10
# Help and about in Element Web settings
ACCESSTOKEN=
NEWROOMNAME="CHANGEME (v$ROOMVERSION)"
# https://develop.element.io (or other Element release), run /devtools and
# enable developer mode. Reads on top of /devtools and Room settings ->
# Advanced
OLDROOMID=
# When developer mode is enabled from /devtools in Element Web, visible in
# the hover menu when pointing a message and selecting "view event source".
# Note: $ is not a character that works without quotes due to signifying a
# variable
LASTEVENTINOLDROOM=''
# https://matrix.org/.well-known/matrix/client
HOMESERVER=matrix-client.matrix.org

set -x

# Creating the new room pointing to old one
# Thanks to https://gist.github.com/turt2live/a99c8e794d6115d4ddfaadb72aabf063#gistcomment-3071780 for the awk
NEWROOMID=$(curl -s -X POST -H "Authorization: Bearer $ACCESSTOKEN" -H "Content-Type: application/json" --data-binary "{\"name\":\"$NEWROOMNAME\",\"room_version\":\"$ROOMVERSION\",\"creation_content\":{\"predecessor\":{\"room_id\":\"$OLDROOMID\",\"event_id\":\"$LASTEVENTINOLDROOM\"}}}" https://$HOMESERVER/_matrix/client/v3/createRoom | awk -F\" '{ printf $4 }')

# Sending a tombstone
curl -s -X PUT -H "Authorization: Bearer $ACCESSTOKEN" -H "Content-Type: application/json" --data-binary "{\"replacement_room\":\"$NEWROOMID\"}" "https://$HOMESERVER/_matrix/client/v3/rooms/$OLDROOMID/state/m.room.tombstone"
set +x

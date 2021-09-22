#!/usr/bin/env bash

# Based on https://gist.github.com/turt2live/a99c8e794d6115d4ddfaadb72aabf063

# Check https://matrix.org/docs/spec/#complete-list-of-room-versions before
# upgrading a room and change as necessary (WARNING: deprecated, no replacement
# that includes versions after 7 at the time of writing)
ROOMVERSION=9
ACCESSTOKEN=
NEWROOMNAME=""
OLDROOMID=
# Note: $ is not a character that worlks without quotes due to signifying a
# variable
LASTEVENTINOLDROOM=''
HOMESERVER=chat.privacytools.io

set -x

# Creating the new room pointing to old one
# Thanks to https://gist.github.com/turt2live/a99c8e794d6115d4ddfaadb72aabf063#gistcomment-3071780 for the awk
NEWROOMID=$(curl -s -X POST -H "Authorization: Bearer $ACCESSTOKEN" -H "Content-Type: application/json" --data-binary "{\"name\":\"$NEWROOMNAME\",\"room_version\":\"$ROOMVERSION\",\"creation_content\":{\"predecessor\":{\"room_id\":\"$OLDROOMID\",\"event_id\":\"$LASTEVENTINOLDROOM\"}}}" https://$HOMESERVER/_matrix/client/r0/createRoom | awk -F\" '{ printf $4 }')

# Sending a tombstone
curl -s -X PUT -H "Authorization: Bearer $ACCESSTOKEN" -H "Content-Type: application/json" --data-binary "{\"replacement_room\":\"$NEWROOMID\"}" "https://$HOMESERVER/_matrix/client/r0/rooms/$OLDROOMID/state/m.room.tombstone"
set +x

#!/usr/bin/env bash

# This is just step 3 from https://gist.github.com/turt2live/a99c8e794d6115d4ddfaadb72aabf063
# which is the one I have a need to perform the most as I have ended up with
# some duplicate rooms.

ACCESSTOKEN=
OLDROOMID=
NEWROOMID=
HOMESERVER=matrix-client.matrix.org

set -x
curl -s -X PUT -H "Authorization: Bearer $ACCESSTOKEN" -H "Content-Type: application/json" --data-binary "{\"replacement_room\":\"$NEWROOMID\"}" "https://$HOMESERVER/_matrix/client/v3/rooms/$OLDROOMID/state/m.room.tombstone"
set +x

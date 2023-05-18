#!/usr/bin/env bash

# As Sway doesn't support display mirroring, using VNC seems like the least
# bad workaround that was suggested in the issue.
# https://github.com/swaywm/sway/issues/1666

set -x

# -r mirrors cursor, eDP-1 is the internal display name on lumina to be mirrored
wayvnc ::1 -r -o eDP-1 &

# So I won't forget it and think something broke
notify-send "Remember to Mod-Shift-NUM to exit black screen"
# So Remmina doesn't start too fast and fail to connect for it.
sleep 5

# remmina is the first wayland using VNC client I encountered. --display is Xorg
# so it will need to be moved to proper workspace and fullscreened manually
remmina --disable-toolbar --enable-fullscreen "vnc://[::1]"

set +x

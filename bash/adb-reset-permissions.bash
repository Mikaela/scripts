#!/usr/bin/env bash
set -x
# As the GUI method did nothing for me, this will hopefully reset all
# permissions of apps on an Android device.
adb "$@" shell pm reset-permissions
adb "$@" reboot
set +x

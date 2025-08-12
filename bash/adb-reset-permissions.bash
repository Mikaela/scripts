#!/usr/bin/env bash
set -x

# Enable adblocking DNS-over-TLS
(adb "$@" shell settings put global private_dns_mode hostname &)
(adb "$@" shell settings put global private_dns_specifier noads.joindns4.eu &)
(adb "$@" shell cmd device_config put netd_native doh 1 &)

sleep 5

# As the GUI method did nothing for me, this will hopefully reset all
# permissions of apps on an Android device.
adb "$@" shell pm reset-permissions
sleep 5
adb "$@" reboot
set +x

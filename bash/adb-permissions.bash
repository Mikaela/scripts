#!/usr/bin/env bash

# This script will set extra permissions through adb for the apps I use so I don't have to look them up again.

# adb global options:
# -a	listen on all network interfaces, not just localhost
# -d	use USB device (error if multiple devices connected)

set -x

# TODO: if adb is not installed or in $PATH, exit?

# Remember,
echo "In case of trouble check Android System Settings, Connected devices, USB mode. It should be data transfer for adb USB debugging to take effect."

# DetoxDroid, https://github.com/flxapps/DetoxDroid/wiki/Manual-Installation
adb "$@" shell pm grant com.flx_apps.digitaldetox android.permission.WRITE_SECURE_SETTINGS
adb "$@" shell dpm set-device-owner com.flx_apps.digitaldetox/.DetoxDroidDeviceAdminReceiver

# Logfox adb reader from F-Droid
adb "$@" shell pm grant com.f0x1d.logfox android.permission.READ_LOGS

# https://github.com/c-lis/morelocale
adb "$@" shell pm grant jp.co.c_lis.ccl.morelocale android.permission.CHANGE_CONFIGURATION

# Shizuku
#(adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh &)
(adb "$@" shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh &)

# If 1, DoH3 is supported
(adb "$@" shell cmd device_config get netd_native doh &)

# Wait a bit and then reboot the device
sleep 5
#adb "$@" reboot

set +x

#!/usr/bin/env bash

# This script will set extra permissions through adb for the apps I use so I don't have to look them up again.

# adb global options:
# -a	listen on all network interfaces, not just localhost
# -d	use USB device (error if multiple devices connected)

set -x

if ! hash adb 2> /dev/null; then
	echo "Error: adb not found in $PATH" 1>&2
	exit 1
fi

# Remember,
echo "In case of trouble check Android System Settings, Connected devices, USB mode. It should be data transfer for adb USB debugging to take effect."

# DetoxDroid, https://github.com/flxapps/DetoxDroid/wiki/Manual-Installation
adb "$@" shell pm grant com.flx_apps.digitaldetox android.permission.WRITE_SECURE_SETTINGS
adb "$@" shell dpm set-device-owner com.flx_apps.digitaldetox/.DetoxDroidDeviceAdminReceiver

# Logfox adb reader from F-Droid
adb "$@" shell pm grant com.f0x1d.logfox android.permission.READ_LOGS

# https://github.com/c-lis/morelocale
adb "$@" shell pm grant jp.co.c_lis.ccl.morelocale android.permission.CHANGE_CONFIGURATION

# https://github.com/karasevm/PrivateDNSAndroid
adb "$@" shell pm grant ru.karasevm.privatednstoggle android.permission.WRITE_SECURE_SETTINGS

# https://userbase.kde.org/KDEConnect#Log_Reading
adb "$@" shell pm grant org.kde.kdeconnect_tp android.permission.READ_LOGS
adb "$@" shell appops set org.kde.kdeconnect_tp SYSTEM_ALERT_WINDOW allow

# https://github.com/cvzi/darkmodewallpaper hopefully fixing Android 14 wallpapers
adb "$@" shell pm grant com.github.cvzi.darkmodewallpaper android.permission.MANAGE_EXTERNAL_STORAGE
adb "$@" shell pm grant com.github.cvzi.darkmodewallpaper android.permission.READ_MEDIA_IMAGES

# Shizuku
#(adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh &)
(adb "$@" shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh &)

# Uninstall or disable Android Safety Core (suspected chatcontrol backdoor)
(adb "$@" shell pm uninstall com.google.android.safetycore &)
#(adb "$@" shell pm disable com.google.android.safetycore &)
# Uninstall or disable Gemini so it won't access other apps
(adb "$@" shell pm uninstall com.google.android.apps.bard &)
#(adb "$@" shell pm disable com.google.android.apps.bard &)

# Enable DNS-over-TLS
(adb "$@" shell settings put global private_dns_mode hostname &)
# If dns.google or cloudflare-dns.com, it will be updated to DoH3
#(adb "$@" shell settings put global private_dns_specifier dns.google &)
(adb "$@" shell settings put global private_dns_specifier noads.joindns4.eu &)
# I thought maybe setting the above to DoH3 and this would together allow
# arbitary DoH3 server, but no
(adb "$@" shell cmd device_config put netd_native doh 1 &)

# Wait a bit and then reboot the device
sleep 5
#adb "$@" reboot

printf "Consider: adb $@ shell settings put global private_dns_specifier dns.adguard-dns.com\n"
printf "Performance issues? adb $@ shell top -b | head\n"
set +x

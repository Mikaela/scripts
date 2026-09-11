#!/usr/bin/env bash
# This is a simple bash script to cheat systemd oneshot not allowing multiple
# commands to be executed and also unifying my setup just a bit

set -x

# Can I simply have a function?
_duperemover() {
	if hash duperemove 2> /dev/null; then
		duperemove -rdhq --io-threads=1 --cpu-threads=1 --hashfile=$1 $2
	else
		echo "duperemove not found"
		exit 1
	fi
}

_balancer() {
	btrfs balance start -dusage=25 -dlimit=10 -musage=25 -mlimit=10 $1
	btrfs balance start -dusage=50 $1
}

if [ ! -d /sysroot/ostree ]; then
	echo "This script currently only targets Fedora Kinoite, because I am lazy"
	exit 1
fi

# Hi systemd, we are starting up or running!
=systemd-notify --ready

# Something says to run this in journalctl, so sure
blkid

# Home directories
_balancer /var/home
_duperemover /root/home.hash /var/home

# root filesystem
_balancer /
_duperemover /root/rootfs.hash /

# where non-home is, although home is too
_balancer /var
_duperemover /root/var.hash /var

# Steam Deck SD card
if [ -d /var/sdcard ]; then
	_balancer /var/sdcard
	_duperemover /var/sdcard
fi

# TODO: Why do I have these?
#_duperemover /root/usr-local-bin.hash /usr/local/bin
#_duperemover /root/flatpak.hash /var/lib/flatpak
#_duperemover /root/snap.hash /var/lib/snapd

set +x

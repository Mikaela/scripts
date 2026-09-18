#!/usr/bin/env bash
# This is a simple bash script to cheat systemd oneshot not allowing multiple
# commands to be executed and also unifying my setup just a bit

set -x

# I can have a simple function to not repeat myself.
# Something complains about "libblkid could not get uuid for device... Run
# blkid as root to populate the cache.", so I am simply running it at every
# point so surely there will be the cache.
_duperemover() {
	blkid
	if hash duperemove 2> /dev/null; then
		duperemove -rdhq --io-threads=1 --cpu-threads=1 --hashfile=$1 $2
	else
		echo "duperemove not found"
		exit 1
	fi
}

_balancer() {
	blkid
	btrfs balance start -dusage=25 -dlimit=10 -musage=25 -mlimit=10 $1
	blkid
	btrfs balance start -dusage=50 $1
}

# Hi systemd, we are starting up or running!
systemd-notify --ready

if [ ! -d /sysroot/ostree ]; then
	_duperemover /root/rootfs.hash /
	# overlayfs is not btrfs filesystem so it can be balanced here
	_balancer /
fi

# Home directories
_balancer /var/home
_duperemover /root/home.hash /var/home

# root filesystem
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
_duperemover /root/usr-local-bin.hash /usr/local/bin
_duperemover /root/flatpak.hash /var/lib/flatpak
if [ -d /var/lib/snapd ]; then
	_duperemover /root/snap.hash /var/lib/snapd
fi

# We are exiting successfully for systemd to know that exit code
exit 0

set +x

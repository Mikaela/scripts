#!/usr/bin/env bash

#set -x

export LC_ALL=C.utf8

# Check for existence of /etc/machine-id/
if [ -f /etc/machine-id ]; then

	# Check for existence of the /boot/<machine-id> directory
	if [ -d /boot/efi/"$(cat /etc/machine-id)" ]; then

		# Store the latest installed kernel to $EXPECTEDKERNEL
		EXPECTEDKERNEL="$(find /lib/modules -maxdepth 1 -printf '%P\n' | sort | tail -n -1)"

		# And actual kernel in the boot/efi directory
		ACTUALKERNEL="$(find /boot/efi/"$(cat /etc/machine-id)"/ -maxdepth 1 -printf '%P\n' | sort | tail -n -1)"

		# Are they the same? Everything OK!
		if [ "$EXPECTEDKERNEL" == "$ACTUALKERNEL" ]; then
			echo "The kernel situation seems OK."

		else
			printf "\nWARNING! Kernels mismatch! Suggested action:\n"
			printf "\tsudo kernel-install add %b /lib/modules/%b/vmlinuz\n" "$EXPECTEDKERNEL" "$EXPECTEDKERNEL"
		fi
	fi
fi

#set +x

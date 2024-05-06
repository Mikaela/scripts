#!/usr/bin/env bash

#set -x

export LC_ALL=C.utf8

# Check for existence of /etc/machine-id/
if [ -f /etc/machine-id ]; then

	# How about we just store the machine-id instead of fetching it
	# constantly?
	MACHINEID="$(cat /etc/machine-id)"
	#echo "Our machine-id is $MACHINEID"

	# Check for existence of the /boot/<machine-id> directory
	if [ -d /boot/efi/"$MACHINEID" ]; then

		# Store the latest installed kernel to $EXPECTEDKERNEL
		EXPECTEDKERNEL="$(find /lib/modules -maxdepth 1 -printf '%P\n' | sort | tail -n -1)"

		# And actual kernel in the boot/efi directory
		ACTUALKERNEL="$(find /boot/efi/"$MACHINEID"/ -maxdepth 1 -printf '%P\n' | sort | tail -n -1)"

		# Are they the same? Everything OK!
		if [ "$EXPECTEDKERNEL" == "$ACTUALKERNEL" ]; then
			echo "The kernel situation seems OK."

		else
			printf "\nWARNING! Kernels mismatch! Suggested actions:\n"
			printf "\tsudo mkdir /boot/%b/%b\n" "$MACHINEID" "$EXPECTEDKERNEL"
			printf "\tsudo kernel-install add %b /lib/modules/%b/vmlinuz\n" "$EXPECTEDKERNEL" "$EXPECTEDKERNEL"
			#printf "\tsudo dnf reinstall kernel-core-%b -y\n" "$EXPECTEDKERNEL"
			printf "Please note that Lumina and Sedric have moved to UKI.\n"
		fi
	fi
fi

#set +x

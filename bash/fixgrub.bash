#!/usr/bin/env bash

# On Sedric Fedora keeps overwriting my grub modifications so I keep
# meeting a strange system including graphical boot screen and not telling
# me what is going on. This is an ugly workaround.

set -x

# This script is Fedora specific for now.

# There is no reason to run if dnf hasn't moved the proper config aside.
if [ -f /boot/efi/EFI/fedora/grub.cfg.rpmsave ]; then
	rm -f /boot/efi/EFI/fedora/grub.cfg.rpmsave
	grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
fi

set +x

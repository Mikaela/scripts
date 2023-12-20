#!/usr/bin/env bash

# Theoretically this should never run
# READ https://fedoraproject.org/wiki/GRUB_2 !!!!!

set -x

# Fedora < 34
#if [ -f /boot/efi/EFI/fedora/grub.cfg.rpmsave ]; then
#	rm -f /boot/efi/EFI/fedora/grub.cfg.rpmsave
#	grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
#fi

# There is no reason to run if dnf hasn't moved the proper config aside.
if [ -f /etc/grub2.cfg.rpmsave ]; then
	rm -f /etc/grub2.cfg.rpmsave
	grub2-mkconfig -o /etc/grub2.cfg
fi

# There is no reason to run if dnf hasn't moved the proper config aside.
if [ -f /etc/grub2-efi.cfg.rpmsave ]; then
	rm -f /etc/grub2-efi.cfg.rpmsave
	grub2-mkconfig -o /etc/grub2-efi.cfg
fi

# There is no reason to run if dnf hasn't moved the proper config aside.
# Legacy boot method for grub update.
# if [ -f /boot/grub2/grub.cfg.rpmsave ]; then
# 	rm -f /boot/grub2/grub.cfg.rpmsave
# 	grub2-mkconfig -o /boot/grub2/grub.cfg
# fi

set +x

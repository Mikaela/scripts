#!/usr/bin/env bash

# On Sedric Fedora keeps overwriting my grub modifications so I keep
# meeting a strange system including graphical boot screen and not telling
# me what is going on. This is an ugly workaround.

set -x
# TODO: If this is to become more sophisciated and check for Fedora
# detect based on /boot/efi/EFI/fedora/grub.cfg, not rpmsave?
rm -f /boot/efi/EFI/fedora/grub.cfg.rpmsave
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
set +x

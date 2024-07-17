#!/usr/bin/env bash

if ! hash darkman 2> /dev/null; then
	echo "You don't seem to have darkman installed." 1>&2
	exit 1
fi

mkdir -vp ~/.local/share/

if [ -d /usr/share/doc/darkman/examples ]; then
	ln -nsfv /usr/share/doc/darkman/examples/{dark,light}-mode.d ~/.local/share/
elif [ -d /usr/local/share/doc/darkman/examples ]; then
	ln -nsfv /usr/local/share/doc/darkman/examples/{dark,light}-mode.d ~/.local/share/
elif [ -d ~/.local/share/doc/darkman/examples ]; then
	ln -nsfv ~/.local/share/doc/darkman/examples/{dark,light}-mode.d ~/.local/share/
elif [ -d ~/src/gitlab.com/WhyNotHugo/darkman ]; then
	ln -nsfv ~/src/gitlab.com/WhyNotHugo/darkman/examples/{dark,light}-mode.d ~/.local/share/
else
	echo "Darkman examples not found in expected locations."
	exit 1
fi

systemctl --user disable --now darkman.service
systemctl --user mask darkman.service
echo "Creating an autostart seems to work better than the systemd service."

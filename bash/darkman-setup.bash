#!/usr/bin/env bash
set -x
if ! hash darkman 2> /dev/null; then
	echo "You don't seem to have darkman installed." 1>&2
	exit 1
fi

if [ ! -d ~/.local/share/dark-mode.d ]; then
	rm ~/.local/share/{dark,light}-mode.d
	mkdir -vp ~/.local/share/{dark,light}-mode.d
	echo "Ensure ~/.local/share/ has directories {dark,light}-mode.d/"
fi

if [ -d /usr/share/doc/darkman/examples ]; then
	export EXAMPLESDIR="/usr/share/doc/darkman/examples"
elif [ -d /usr/local/share/doc/darkman/examples ]; then
	export EXAMPLESDIR="/usr/local/share/doc/darkman/examples"
elif [ -d ~/.local/share/doc/darkman/examples ]; then
	export EXAMPLESDIR="/.local/share/doc/darkman/examples"
elif [ -d ~/src/gitlab.com/WhyNotHugo/darkman/examples ]; then
	export EXAMPLESDIR="~/src/gitlab.com/WhyNotHugo/darkman/examples"
else
	echo "Darkman examples not found in expected locations."
	exit 1
fi

ln -nsfv $EXAMPLESDIR/dark-mode.d/* ~/.local/share/dark-mode.d/
ln -nsfv $EXAMPLESDIR/light-mode.d/* ~/.local/share/light-mode.d/

unset $EXAMPLESDIR
systemctl --user disable --now darkman.service
systemctl --user mask darkman.service
echo "Creating an autostart seems to work better than the systemd service."
set +x

#!/usr/bin/env bash

# An attempt to not repeat myself with commands I return to constantly

_inhibitshutdowncmd() {
	if hash systemd-inhibit 2> /dev/null; then
		systemd-inhibit --what shutdown --who "$INHIBITWHO" --why "$INHIBITWHO blocks shutdown/reboot" $@
	else
		$@
	fi
}

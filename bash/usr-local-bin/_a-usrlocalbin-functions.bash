#!/usr/bin/env bash

# An attempt to not repeat myself with commands I return to constantly

_inhibitshutdowncmd() {
	if hash systemd-inhibit 2> /dev/null; then
		systemd-inhibit --what shutdown --who "$INHIBITWHO" --why "$INHIBITWHO blocks shutdown/reboot" $@
	else
		$@
	fi
}

_gigaramhalfcpu() {
	if hash systemd-run 2> /dev/null; then
		systemd-run --scope --user --property=MemoryHigh=1G --property=CPUQuota=50% $@
	else
		$@
	fi
}

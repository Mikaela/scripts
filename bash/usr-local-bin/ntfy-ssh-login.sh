#!/usr/bin/env bash
# This is based on https://docs.ntfy.sh/examples/#ssh-login-alerts
# I just want to have it use ntfy if installed and not include the topic for
# portability
# Usage: append to /etc/pam.d/sshd:
# session optional pam_exec.so /usr/local/bin/ntfy-ssh-login.sh ntfy.sh/alerts

if [ "${PAM_TYPE}" = "open_session" ]; then
	if command -v ntfy > /dev/null 2>&1; then
		ntfy publish -p high --tags=warning $1 "$(hostname) SSH login: ${PAM_USER} from ${PAM_RHOST}"
	elif [ -f /home/linuxbrew/.linuxbrew/bin/ntfy ]; then
		/home/linuxbrew/.linuxbrew/bin/ntfy publish -p high --tags=warning $1 "$(hostname) SSH login: ${PAM_USER} from ${PAM_RHOST}"
	else
		curl \
			-H prio:high \
			-H tags:warning \
			-d "$(hostname) SSH login: ${PAM_USER} from ${PAM_RHOST}" \
			$1
	fi
fi

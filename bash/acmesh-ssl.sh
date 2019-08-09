#!/bin/bash

# ssl.sh - for acme.sh edition

# WARNING!
# Check file permissions very carefully so other users cannot access the
# certificate copies.
# Used with crontab.

# The domain the certs are mainly issued for
DOMAINNAME=relpda.mikaela.info

# Where is acme.sh + flags applying to them all
ACMESH="/root/.acme.sh/acme.sh --install-cert -d $DOMAINNAME"

# Syncplay - TODO https://github.com/Syncplay/syncplay/issues/250
$ACMESH --cert-file /opt/syncplay/ssl/cert.pem --key-file /opt/syncplay/ssl/privkey.pem --fullchain-file /opt/syncplay/ssl/chain.pem --reloadcmd "systemctl restart syncplay-server --quiet"
chmod -R 700 /opt/syncplay/ssl
chown -R syncplay:root /opt/syncplay/ssl

# Mumble
$ACMESH --fullchain-file /var/lib/mumble-server/ssl/fullchain.cer --key-file /var/lib/mumble-server/ssl/$DOMAINNAME.key --reloadcmd "systemctl restart mumble-server --quiet"
# future on 1.3.0 +
# --reloadcmd "pkill $(cat /var/run/mumble-server/mumble-server.pid) -USR1"
chmod -R 700 /var/lib/mumble-server/ssl/
chown -R mumble-server:mumble-server /var/lib/mumble-server/ssl/

# ZNC 1.7.0 (SSLCertFile & SSLKeyFile in znc.conf)
# znc.conf's SSLDHParamFile is created by `openssl dhparam 2048 > /home/znc/.znc/ssl/dh.pem`
$ACMESH --fullchain-file /home/znc/.znc/ssl/fullchain.cer --key-file /home/znc/.znc/ssl/$DOMAINNAME.key
chmod -R 700 /home/znc/.znc/ssl/
chown -R znc:znc /home/znc/.znc/ssl/

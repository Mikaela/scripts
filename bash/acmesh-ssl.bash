#!/bin/bash

# ssl.sh - for acme.sh edition

# WARNING!
# Check file permissions very carefully so other users cannot access the
# certificate copies.
# Used with crontab as root, remember `@daily bash /root/acmesh-ssl.sh >/dev/null 2>&1`

# Echo a warning and exit if NOT running as root
if [ "$(id -u)" != "0" ]; then
   echo "acme.sh prefers root, this script demands it." 1>&2
   exit 1
fi

# The domain the certs are mainly issued for
DOMAINNAME=relpda.mikaela.info
# Directories
SYNCPLAYDIR=/opt/syncplay/ssl
MUMBLEDIR=/var/lib/mumble-server/ssl
ZNCDIR=/home/znc/.znc/ssl
NGINXDIR=/etc/nginx/ssl

# Where is acme.sh + flags applying to them all
ACMESH="/root/.acme.sh/acme.sh --install-cert -d $DOMAINNAME"

# restarting with systemctl
SYSTEMCTLRESTART="systemctl restart --quiet"
SYSTEMCTLRELOAD="systemctl reload --quiet"

# Start by creating the directories if they don't exist
/bin/mkdir -p $SYNCPLAYDIR $MUMBLEDIR $ZNCDIR $NGINXDIR

# Syncplay - note: reloads certs on every connect like ZNC
$ACMESH --cert-file $SYNCPLAYDIR/cert.pem --key-file $SYNCPLAYDIR/privkey.pem --ca-file $SYNCPLAYDIR/chain.pem
chmod -R 700 $SYNCPLAYDIR
chown -R syncplay:root $SYNCPLAYDIR

# Mumble
$ACMESH --fullchain-file $MUMBLEDIR/fullchain.cer --key-file $MUMBLEDIR/$DOMAINNAME.key --reloadcmd "$SYSTEMCTLRESTART mumble-server"
# future on 1.3.0 +
# --reloadcmd "/usr/bin/pkill $(cat /var/run/mumble-server/mumble-server.pid) -USR1"
chmod -R 700 $MUMBLEDIR/
chown -R mumble-server:mumble-server $MUMBLEDIR/

# ZNC 1.7.0 (SSLCertFile & SSLKeyFile in znc.conf)
# znc.conf's SSLDHParamFile is created by `openssl dhparam 2048 > $ZNCDIRdh.pem`
$ACMESH --fullchain-file $ZNCDIR/fullchain.cer --key-file $ZNCDIR/$DOMAINNAME.key
chmod -R 700 $ZNCDIR
chown -R znc:znc $ZNCDIR

# nginx
$ACMESH --key-file $NGINXDIR/key.pem --fullchain-file $NGINXDIR/cert.pem --reloadcmd "$SYSTEMCTLRESTART nginx"
chmod -R 700 $NGINXDIR
chown -R root:root $NGINXDIR

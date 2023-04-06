#!/bin/bash

# ssl.sh - for acme.sh edition

# WARNING!
# Check file permissions very carefully so other users cannot access the
# certificate copies.
# Used with crontab as root, remember `@daily bash /root/acmesh-ssl.bash >/dev/null 2>&1`

# Echo a warning and exit if NOT running as root
if [ "$(id -u)" != "0" ]; then
	echo "acme.sh prefers root, this script demands it." 1>&2
	exit 1
fi

# The domain the certs are mainly issued for
DOMAINNAME=etro.mikaela.info
# Directories
SYNCPLAYDIR=/opt/syncplay/ssl
MUMBLEDIR=/var/lib/mumble-server/ssl
ZNCDIR=/home/znc/.znc/ssl
NGINXDIR=/etc/nginx/ssl
ORAGONODIR=/home/oragono/oragono-conf
WEECHATDIR=/home/mikaela/.weechat/ssl
CHRONYDIR=/etc/chrony/tls

# Where is acme.sh + flags applying to them all
ACMESH="/root/.acme.sh/acme.sh --install-cert"

# restarting with systemctl
SYSTEMCTLRESTART="systemctl restart --quiet"
SYSTEMCTLRELOAD="systemctl reload --quiet"

# Start by creating the directories if they don't exist
/bin/mkdir -p $SYNCPLAYDIR $MUMBLEDIR $ZNCDIR $NGINXDIR $ORAGONODIR $WEECHATDIR $CHRONYDIR

# Syncplay - note: reloads certs on every connect like ZNC
$ACMESH -d $DOMAINNAME --cert-file $SYNCPLAYDIR/cert.pem --key-file $SYNCPLAYDIR/privkey.pem --ca-file $SYNCPLAYDIR/chain.pem
chmod -R 700 $SYNCPLAYDIR
chown -R syncplay:root $SYNCPLAYDIR

# Mumble
$ACMESH -d $DOMAINNAME --fullchain-file $MUMBLEDIR/fullchain.cer --key-file $MUMBLEDIR/$DOMAINNAME.key --reloadcmd "$SYSTEMCTLRESTART mumble-server"
# future on 1.3.0 +
# --reloadcmd "/usr/bin/pkill $(cat /var/run/mumble-server/mumble-server.pid) -USR1"
chmod -R 700 $MUMBLEDIR/
chown -R mumble-server:mumble-server $MUMBLEDIR/

# ZNC 1.7.0 (SSLCertFile & SSLKeyFile in znc.conf)
# znc.conf's SSLDHParamFile is created by `openssl dhparam 2048 > $ZNCDIRdh.pem`
$ACMESH -d $DOMAINNAME --fullchain-file $ZNCDIR/fullchain.cer --key-file $ZNCDIR/$DOMAINNAME.key
chmod -R 700 $ZNCDIR
chown -R znc:znc $ZNCDIR

# nginx
$ACMESH -d $DOMAINNAME --key-file $NGINXDIR/key.pem --fullchain-file $NGINXDIR/cert.pem --reloadcmd "$SYSTEMCTLRESTART nginx"
chmod -R 700 $NGINXDIR
chown -R root:root $NGINXDIR

# Egro IRCd, previously known as Oragono
$ACMESH -d $DOMAINNAME --key-file $ORAGONODIR/privkey.pem --fullchain-file $ORAGONODIR/fullchain.pem --reloadcmd "$SYSTEMCTLRELOAD oragono"
chmod -R 700 $ORAGONODIR
chown -R oragono:oragono $ORAGONODIR

# WeeChat relay, remember to /relay sslcertkey
$ACMESH -d $DOMAINNAME --fullchain-file $WEECHATDIR/fullchain.pem --key-file $WEECHATDIR/privkey.pem
cat $WEECHATDIR/{fullchain,privkey}.pem > $WEECHATDIR/relay.pem
chmod -R 700 $WEECHATDIR
chown -R mikaela:mikaela $WEECHATDIR

# Chrony (for running as an NTS server)
$ACMESH -d $DOMAINNAME -key-file $CHRONYDIR/$DOMAINNAME.key --fullchain-file $CHRONYDIR/$DOMAINNAME.crt --reloadcmd "$SYSTEMCTLRESTART chronyd"
chown -R 700 $CHRONYDIR
# NOTE THE NAMES!
chown -R _chrony:_chrony $CHRONYDIR

# Another domain
DOMAINNAME=T4.114077943.xyz

# Nginx for another domain
$ACMESH -d $DOMAINNAME --key-file $NGINXDIR/$DOMAINNAME.key.pem --fullchain-file $NGINXDIR/$DOMAINNAME.cert.pem --reloadcmd "$SYSTEMCTLRESTART nginx"
chmod -R 700 $NGINXDIR
chown -R root:root $NGINXDIR

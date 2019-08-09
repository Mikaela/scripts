#!/bin/bash

# ssl.sh - for acme.sh edition

# WARNING!
# Check file permissions very carefully so other users cannot access the
# certificate copies.
# Used with crontab.

# The domain the certs are mainly issued for and is part of the CERTDIR name
DOMAINNAME=relpda.mikaela.info
# Where the certificates are stored
CERTDIR=/root/.acme.sh/$DOMAINNAME

# Syncplay - TODO https://github.com/Syncplay/syncplay/issues/250
cp $CERTDIR/fullchain.cer /opt/syncplay/ssl/chain.pem
cp $CERTDIR/$DOMAINNAME.key /opt/syncplay/ssl/privkey.pem
cp $CERTDIR/$DOMAINNAME.cer /opt/syncplay/ssl/cert.pem
chmod -R 700 /opt/syncplay/ssl
chown -R syncplay:root /opt/syncplay/ssl

# Mumble
cp $CERTDIR/{fullchain.cer,$DOMAINNAME.key} /var/lib/mumble-server/ssl/
chmod -R 700 /var/lib/mumble-server/ssl/
chown -R mumble-server:mumble-server /var/lib/mumble-server/ssl/
# 1.3.0+ reloads certificate without restart on SIGUSR1
pkill $(cat /var/run/mumble-server/mumble-server.pid) -USR1

# ZNC originally via https://wiki.znc.in/Signed_SSL_certificate#Certbot
# then adjusted to certbot as Mumble above
cat $CERTDIR/{$DOMAINNAME.key,fullchain.cer} > /home/znc/.znc/znc.pem
chmod 700 /home/znc/.znc/znc.pem
chown znc:znc /home/znc/.znc/znc.pem
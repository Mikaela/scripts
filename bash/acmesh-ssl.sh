#!/bin/bash

# ssl.sh - for acme.sh edition

# WARNING!
# Check file permissions very carefully so other users cannot access the
# certificate copies.
# Used with crontab.

# Where the certificate files are
CERTDIR=/root/.acme.sh/relpda.mikaela.info
# TODO when it generally works
#DOMAINNAME=relpda.mikaela.info

# Syncplay - TODO https://github.com/Syncplay/syncplay/issues/250
cp $CERTDIR/fullchain.cer /opt/syncplay/ssl/chain.pem
cp $CERTDIR/relpda.mikaela.info.key /opt/syncplay/ssl/privkey.pem
cp $CERTDIR/relpda.mikaela.info.cer /opt/syncplay/ssl/cert.pem
chown -R syncplay:root /opt/syncplay/ssl

# Mumble
cp $CERTDIR/{fullchain.cer,relpda.mikaela.info.key} /var/lib/mumble-server/ssl/
chown -R mumble-server:mumble-server /var/lib/mumble-server/ssl/
# 1.3.0+ reloads certificate without restart on SIGUSR1
pkill $(cat /var/run/mumble-server/mumble-server.pid) -USR1

# ZNC originally via https://wiki.znc.in/Signed_SSL_certificate#Certbot
# then adjusted to certbot as Mumble above
cat $CERTDIR/{relpda.mikaela.info.key,fullchain.cer} > /home/znc/.znc/znc.pem

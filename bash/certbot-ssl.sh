#!/bin/bash

# WARNING!
# Check file permissions very carefully so other users cannot access the
# certificate copies.
# Used with crontab.

# Syncplay
cp /etc/letsencrypt/live/relpda.mikaela.info/* /opt/syncplay/ssl/
chown -R syncplay:root /opt/syncplay/ssl

# Mumble
cp /etc/letsencrypt/live/relpda.mikaela.info/* /var/lib/mumble-server/ssl/
chown -R mumble-server:mumble-server /var/lib/mumble-server/ssl/
# 1.3.0+ reloads certificate without restart on SIGUSR1
pkill $(cat /var/run/mumble-server/mumble-server.pid) -USR1

# ZNC via https://wiki.znc.in/Signed_SSL_certificate#Certbot
cat /etc/letsencrypt/live/relpda.mikaela.info/{privkey,fullchain}.pem > /home/znc/.znc/znc.pem

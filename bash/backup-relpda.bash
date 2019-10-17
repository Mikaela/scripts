#!/usr/bin/env bash

TARGETDIR=/home/mikaela/backups/

mkdir -p $TARGETDIR

cp -rv /home/znc/.znc/ $TARGETDIR/znc

mkdir -p $TARGETDIR/bitbot/
cp -v /home/bitbot/bitbot/bot.conf /home/bitbot/bitbot/databases/bot.db $TARGETDIR/bitbot/
cp -rv /home/botbot/.bitbot/ $TARGETDIR/bitbot/dotbitbot/

# Think about ssh keys? But I don't rotate hostnames with VPSes...
cp -v /etc/yggdrasil.conf $TARGETDIR

cp -v /etc/systemd/system/syncplay-server.service $TARGETDIR

mkdir -p $TARGETDIR/mumble/ssl/
cp -v /etc/mumble-server.ini /var/lib/mumble-server/mumble-server.sqlite $TARGETDIR/mumble/
cp -vr /var/lib/mumble-server/ssl/ $TARGETDIR/mumble/ssl

chown -R mikaela:mikaela $TARGETDIR
chmod -R g-rxw,o-rxw $TARGETDIR

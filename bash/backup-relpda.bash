#!/usr/bin/env bash
set -x
TARGETDIR=/home/mikaela/backups/

mkdir -p $TARGETDIR

rsync -avr /home/znc/.znc/ $TARGETDIR/znc

mkdir -p $TARGETDIR/bitbot/
rsync -avr /home/bitbot/bitbot/bot.conf /home/bitbot/bitbot/databases/bot.db $TARGETDIR/bitbot/
rsync -avr /home/bitbot/.bitbot/ $TARGETDIR/bitbot/dotbitbot/

# Think about ssh keys? But I don't rotate hostnames with VPSes...
rsync -avr /etc/yggdrasil.conf $TARGETDIR

rsync -avr /etc/systemd/system/syncplay-server.service $TARGETDIR

mkdir -p $TARGETDIR/mumble/ssl/
rsync -avr /etc/mumble-server.ini /var/lib/mumble-server/mumble-server.sqlite $TARGETDIR/mumble/
rsync -avr /var/lib/mumble-server/ssl/ $TARGETDIR/mumble/ssl

rsync -avr /etc/oidentd.conf $TARGETDIR

mkdir -p $TARGETDIR/thelounge/
rsync -avr /etc/thelounge/ $TARGETDIR/thelounge/

mkdir -p $TARGETDIR/matterbridge/
rsync -avr /home/matterbridge/config/matterbridge.toml $TARGETDIR/matterbridge
rsync -avr /etc/systemd/system/matterbridge.service $TARGETDIR/matterbridge/matterbridge.service

chown -R mikaela:mikaela $TARGETDIR
chmod -R g-rxw,o-rxw $TARGETDIR
set +x

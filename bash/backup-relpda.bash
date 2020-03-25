#!/usr/bin/env bash

TARGETDIR=/home/mikaela/backups/

mkdir -p $TARGETDIR

rsync -av /home/znc/.znc/ $TARGETDIR/znc

mkdir -p $TARGETDIR/bitbot/
rsync -av /home/bitbot/bitbot/bot.conf /home/bitbot/bitbot/databases/bot.db $TARGETDIR/bitbot/
rsync -av /home/bitbot/.bitbot/ $TARGETDIR/bitbot/dotbitbot/

# Think about ssh keys? But I don't rotate hostnames with VPSes...
rsync -av /etc/yggdrasil.conf $TARGETDIR

rsync -av /etc/systemd/system/syncplay-server.service $TARGETDIR

mkdir -p $TARGETDIR/mumble/ssl/
rsync -av /etc/mumble-server.ini /var/lib/mumble-server/mumble-server.sqlite $TARGETDIR/mumble/
rsync /var/lib/mumble-server/ssl/ $TARGETDIR/mumble/ssl

rsync -av /etc/oidentd.conf $TARGETDIR

mkdir -p $TARGETDIR/thelounge/
rsync -av /etc/thelounge/ $TARGETDIR/thelounge/

mkdir -p $TARGETDIR/matterbridge/
rsync -av /home/matterbridge/config/matterbridge.toml $TARGETDIR/matterbridge
rsync -av /etc/systemd/system/matterbridge.service $TARGETDIR/matterbridge/matterbridge.service

chown -R mikaela:mikaela $TARGETDIR
chmod -R g-rxw,o-rxw $TARGETDIR

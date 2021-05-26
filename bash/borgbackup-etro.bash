#!/usr/bin/env bash
export BORG_REPO='/root/borgbackups-etro.mikaela.info'

borg create ::$(date -Is) /home/bitbot/.bitbot /home/matterbridge/ /home/oragono/oragono-conf /home/mikaela/.weechat /home/limnoria/R-66Y

rm -rf /home/mikaela/backups/
cp -r $BORG_REPO /home/mikaela/backups/
chown -R mikaela:mikaela /home/mikaela/

borg prune -v --keep-daily=7 --keep-weekly=4

#!/usr/bin/env bash
export BORG_REPO='/root/borgbackups-etro.mikaela.info'

borg create ::$(date -Is) /home/bitbot/.bitbot /home/matterbridge/ /home/oragono/oragono-conf

rm -rf /home/mikaela/backups/
cp -r $BORG_REPO /home/mikaela/backups/
chown -R mikaela:mikaela /home/mikaela/

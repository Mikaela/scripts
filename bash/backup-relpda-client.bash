#!/usr/bin/env bash
mkdir -p ~/relpda.mikaela.info/
cd ~/relpda.mikaela.info/

rsync -Paz y.relpda.mikaela.info:~/backups/ .

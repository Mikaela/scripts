#!/usr/bin/env bash
mkdir -p ~/etro.mikaela.info/
cd ~/etro.mikaela.info/

rsync -Paz etro.mikaela.info:~/backups/ .

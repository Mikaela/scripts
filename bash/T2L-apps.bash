#!/usr/bin/env bash
mkdir -p ~/.config/T2L-telegram
telegram-desktop -many -workdir ~/.config/T2L-telegram -startintray&
flatpak run im.riot.Riot --profile T2L --hidden&

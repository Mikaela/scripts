#!/usr/bin/env bash

# This is just a quick script to get mp3 files for 200X or early 201X vinyl
# player that happens to have a USB port and mp3 logo and doesn't accept
# anything else.
#
# I accidentally plotted this in my head drinking tea outside.

set -x

# Without ffmpeg we are doomed to fail
if ! hash ffmpeg 2> /dev/null; then
	echo "ffmpeg not found"
	exit 1
fi

# Convert flacs
for flac in *.flac; do
	if [ -f "$flac.mp3" ]; then
		echo "$flac.mp3 already exists"
	else
		ffmpeg -i "$flac" "$flac.mp3"
	fi
done

# Convert opus files too since yt-dlp has resulted into them
for opus in *.opus; do
	if [ -f "$opus.mp3" ]; then
		echo "$opus.mp3 already exists"
	else
		ffmpeg -i "$opus" "$opus.mp3"
	fi
done

# TODO: The output have silly extensions MUSIC.{flac,opus}.mp3

set +x

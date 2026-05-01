#!/usr/bin/env bash

set -x

# Pratcially more reasonable version of music-to-mp3.bash, but with more
# applicable/modern use-case than ancient mp3 players.

# Without ffmpeg we are doomed to fail
if ! hash ffmpeg 2> /dev/null; then
	echo "ffmpeg not found"
	exit 1
fi

# Convert flacs
for flac in *.flac; do
	if [ -f "$flac.opus" ]; then
		echo "$flac.opus already exists"
	else
		ffmpeg -i "$flac" "$flac.opus"
	fi
done

# TODO: The output have silly extension .flac.opus

set +x

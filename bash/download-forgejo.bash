#!/usr/bin/env bash
VERSION=1.18.3-2
PLATFORM=linux-amd64

# If the signature is already downloaded, don't redownload it
if [ -f "forgejo-$VERSION-$PLATFORM.asc" ]
then
	printf "Forĝejo signature already downloaded.\n"
else
	printf "Downloading Forĝejo $VERSION-$PLATFORM signature…\n"
	curl -LO "https://codeberg.org/forgejo/forgejo/releases/download/v$VERSION/forgejo-$VERSION-$PLATFORM.asc"
fi

# If the binary is already downloaded, don't redownload it
if [ -f "forgejo-$VERSION-$PLATFORM" ]
then
	printf "Forĝejo already downloaded.\n"
else
	printf "Downloading Forĝejo $VERSION on $PLATFORM…\n"
	curl -LO "https://codeberg.org/forgejo/forgejo/releases/download/v$VERSION/forgejo-$VERSION-$PLATFORM"
fi

# The last easy to automate part.
printf "Verifying signature…\n"
gpg --verify forgejo-$VERSION-$PLATFORM.asc

printf "Final steps: \n\t 1. Place the binary. \n\t \
2. sudo ln -s forgejo-$VERSION-$PLATFORM gitea \n\t \
3. sudo systemctl restart gitea \n\t 4. If the\
binary was renamed, run hook update from Forĝejo settings."

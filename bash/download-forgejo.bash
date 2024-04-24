#!/usr/bin/env bash
VERSION=1.19.1-0
PLATFORM=linux-amd64

# If the signature is already downloaded, don't redownload it
if [ -f "forgejo-$VERSION-$PLATFORM.asc" ]; then
	printf "Forĝejo signature already downloaded.\n"
else
	printf "Downloading Forĝejo %b-%b signature…\n" "$VERSION" "$PLATFORM"
	curl -LO "https://codeberg.org/forgejo/forgejo/releases/download/v$VERSION/forgejo-$VERSION-$PLATFORM.asc"
fi

# If the binary is already downloaded, don't redownload it
if [ -f "forgejo-$VERSION-$PLATFORM" ]; then
	printf "Forĝejo already downloaded.\n"
else
	printf "Downloading Forĝejo %b on %b\n" "$VERSION" "$PLATFORM"
	curl -LO "https://codeberg.org/forgejo/forgejo/releases/download/v$VERSION/forgejo-$VERSION-$PLATFORM"
fi

# The last easy to automate part.
printf "Verifying signature…\n"
gpg --verify forgejo-$VERSION-$PLATFORM.asc

printf "Final steps: \n\t 1. Place the binary where the systemd service expects it.\n\t \
2. sudo chmod a+rx forgejo-%b-%b\n\t \
3. sudo ln -sf forgejo-%b-%b gitea \n\t \
4. sudo systemctl restart gitea" "$VERSION" "$PLATFORM" "$VERSION" "$PLATFORM"
echo

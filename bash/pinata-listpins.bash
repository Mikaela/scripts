#!/usr/bin/env bash

# Fill me
PINATAAPIKEY=
PINATASECRETAPIKEY=

# -H = add header, -X GET = get request, tee = create a file and store outpot there
curl -H "pinata_api_key: $PINATAAPIKEY" -H "pinata_secret_api_key: $PINATASECRETAPIKEY" "https://api.pinata.cloud/data/pinList?status=pinned" -X GET | tee response.json

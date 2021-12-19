#!/usr/bin/env bash

# Generates QR codes for wellbeing region elections 2022 or whatever they are
# in English

# TODO: apparently qrencode can read input from a file. Read how that works?

TARGETDIR=$(mktemp -d)
cd $TARGETDIR

echo "Creating to $TARGETDIR"

# Function to generate QRs based on our URL scheme
function generateQr () {
    # $2 is first for the output as there are more regions than associations,
    #  avoids overwriting
    # -H = 30 % damage allowing highest error correction
    qrencode -l H -o $2.png "https://piraattipuolue.fi/yhdistykset/$1/aluevaaliehdokkaat-2022-$2"
}

# Calling the function with associations and regions, they should be
# trivial to add.
generateQr "lapin-piraatit" "lappi"
generateQr "oulun-seudun-piraatit" "pohjois-pohjanmaa"
generateQr "oulun-seudun-piraatit" "kainuu"
generateQr "vaasan-piraatit" "pohjanmaa"
generateQr "vaasan-piraatit" "etela-pohjanmaa"
generateQr "satakunnan-piraatit" "satakunta"
generateQr "pirkanmaan-piraatit" "pirkanmaa"
generateQr "savo-karjalan-piraatit" "pohjois-karjala"
generateQr "hameen-piraatit" "kanta-hame"
generateQr "hameen-piraatit" "paijat-hame"
generateQr "uudenmaan-piraatit" "vantaa-kerava"
generateQr "kaakkois-suomen-piraatit" "etela-savo"
generateQr "varsinais-suomen-piraatit" "varsinais-suomi"
generateQr "kaakkois-suomen-piraatit" "kymenlaakso"
generateQr "kaakkois-suomen-piraatit" "etela-karjala"
generateQr "uudenmaan-piraatit" "lansi-uusimaa"
generateQr "uudenmaan-piraatit" "keski-uusimaa"
generateQr "uudenmaan-piraatit" "ita-uusimaa"

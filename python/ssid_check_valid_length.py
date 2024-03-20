#!/usr/bin/env python3
"""
This script asks for a SSID name, counts it and tells whether it's of valid
length
"""


def check_ssid_length(given_ssid_length):
    """
    This function checks that the given string is below 32 characters long and
    can thus be used as an SSID.
    """
    # 32 bytes should be the maximum SSID length
    if given_ssid_length <= 32:
        print(GIVENSSID, "is", given_ssid_length, "long and thus valid length")
    else:
        print(
            GIVENSSID,
            "is",
            given_ssid_length,
            "to long, please select a different SSID",
        )


# Request input or assume "test" on empty.
GIVENSSID = str(
    input(
        "Please enter the SSID you are thinking of (preferably 26 chars to fit _nomap): ",
    )
    or "test",
)

# Ensure it's UTF-8 and store the size. E.g. åäö are longer than oao
# TODO: make this a function too
GIVENSSIDLEN = len(GIVENSSID.encode("utf8"))

# Checking the SSID length is done twice, so thus a function

# Checking the SSID without _nomap
check_ssid_length(GIVENSSIDLEN)

# Continuing with _nomap to ensure it also fits
GIVENSSID = GIVENSSID + "_nomap"
check_ssid_length(GIVENSSIDLEN)

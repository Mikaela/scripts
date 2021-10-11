#!/usr/bin/env python3

'''
This script asks for a SSID name, counts it and tells whether it's of valid
length
'''

# Request input or assume "test" on empty.
givenssid = str(input("Please enter the SSID you are thinking of (preferably 26 chars to fit _nomap): ") or "test")

# Ensure it's UTF-8 and store the size. E.g. åäö are longer than oao
# TODO: make this a function too
givenssidlen = len(givenssid.encode("utf8"))

# Checking the SSID length is done twice, so thus a function
def checkssidlen(givenssidlen):
    # 32 bytes should be the maximum SSID length
    if givenssidlen <= 32:
        print(givenssid, "is", givenssidlen, "long and thus valid length")
    else:
        print(givenssid, "is", givenssidlen, "to long, please select a different SSID")

# Checking the SSID without _nomap
checkssidlen(givenssidlen)
# TODO: make this a function too
givenssidlen = len(givenssid.encode("utf8"))

# Continuing with _nomap to ensure it also fits
givenssid = givenssid + "_nomap"
checkssidlen(givenssidlen)

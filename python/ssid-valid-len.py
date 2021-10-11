#!/usr/bin/env python3

'''
This script asks for a SSID name, counts it and tells whether it's of valid
length
'''

# Request input
givenssid = input("Please enter the SSID you are thinking of: ")
#givenssid = "test_nomap"

# Ensure it's UTF-8 and store the size. E.g. åäö are longer than oao
givenssidlen = len(givenssid.encode("utf8"))

# 32 bytes should be the maximum SSID length
if givenssidlen <= 32:
    print(givenssid, "is", givenssidlen, "long and thus valid length")
else:
    print("Too long, try again")

#!/usr/bin/env python
"""
Takes desired PIN length as an argument and generates a PIN code of that
length.
"""
import secrets
import sys

try:
    wantedCount = int(sys.argv[1])
except IndexError as noarg:
    print("Enter a digit as an argument!")

try:
    for i in range(int(wantedCount)):
        print(secrets.randbelow(10), end="")
except NameError as noWantedCount:
    print()
print()

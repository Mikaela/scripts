#!/usr/bin/env python
import sys
import secrets

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

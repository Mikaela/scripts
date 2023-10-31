#!/usr/bin/env python
"""
Takes desired PIN length as an argument and generates a PIN code of that
length.
"""
import secrets
import sys


def main():
    """
    This is where the magic happens.
    """
    try:
        desired_length = int(sys.argv[1])
    except IndexError:
        print("Enter a digit as an argument!")

    try:
        for i in range(int(desired_length)):
            print(secrets.randbelow(10), end="")
            # We satisfy pylint by having the variable here.
            # TODO:make this a while loop?
            i += 1
    except NameError:
        print()
    print()


if __name__ == "__main__":
    main()

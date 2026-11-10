#!/usr/bin/env python3
"""
This script suggests a channel and subcodes to use with PMR446 radios.
"""

import random


def main():
    """
    Main function to call the actual function
    """
    generate_channels()


def generate_channels():
    """
    Generate and print suggestions for PMR446 channels. The preferred
    suggestion avoids cheaper and likely more used devices alongside those
    who don't unlock the rest of the range.'
    """

    old_range = int(random.randrange(1, 8))
    new_range = int(random.randrange(9, 16))
    full_range = int(random.randrange(1, 16))
    analog_subcode = int(random.randrange(1, 38))
    digital_subcode = int(random.randrange(39, 121))
    any_subcode = int(random.randrange(1, 121))

    print("PMR446 channel suggestions:")
    print(
        "Any channel: "
        + str(full_range)
        + "\t\t Channel for older subset: "
        + str(old_range)
        + "\t\tChannel for avoiding those: "
        + str(new_range)
    )
    print(
        "Any subcode: "
        + str(any_subcode)
        + "\t\t Analog subcode: "
        + str(analog_subcode)
        + "\t\t\tDigital subcode: "
        + str(digital_subcode)
    )

    print("\nPreferred suggestion:")
    print(
        "Analog:",
        str(new_range) + "-" + str(analog_subcode),
        "Digital:",
        str(new_range) + "-" + str(digital_subcode),
    )


# if calling ./pmr446.py directly
if __name__ == "__main__":
    main()

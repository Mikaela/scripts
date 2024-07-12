"""
Sovellus vertailee totuusarvoja (boolean)
"""

import datetime

tanaan = datetime.date.today()
vuosi = int(tanaan.year)
nimi = "Jussi"

print(vuosi)
print(vuosi == 2014)
print(vuosi is vuosi)

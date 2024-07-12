"""
Sovellus tekee yksinkertaisen salasanatarkistuksen if:illä
"""

KOODISANA = "python"

print("Tervetuloa")
syote = input("Anna salasana: ")

if syote == KOODISANA:
    print("Matka voi alkaa")
else:
    print("Yritä uudelleen")

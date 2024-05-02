"""
Sovellus tekee yksinkertaisen salasanatarkistuksen if:illä
"""

koodisana = "python"

print("Tervetuloa")
syote = input("Anna salasana: ")

if syote == koodisana:
    print("Matka voi alkaa")
else:
    print("Yritä uudelleen")

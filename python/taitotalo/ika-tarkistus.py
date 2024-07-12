"""
Sovellus kysyy käyttäjän ikää, kertoo alle 18 heidän olevan alaikäinen, 18-65 aikuinen ja yli 65 seniori.

"""

# Tuo sys -kirjasto, jotta voimme poistua virhekoodiin.
import sys

# Odotetaan käyttäjän mahdollisesti pyrkivän syöttämään muutakin kuin numeroita ja varaudutaan asiaan
try:
    # Tallennetaan kokonaislukuna käyttäjältä pyydetty ikä
    ika = int(input("Mikä on ikäsi? "))
# Annetaan käyttäjäystävällinen virheilmoitus ja poistutaan virhekoodilla, jos käyttäjä ei syöttänyt numeroita
except ValueError:
    print("Syötä ikäsi numeroina!")
    sys.exit(1)

# Aloitetaan kokeilemalla onko käyttäjä alle 18.
if ika < 18:
    print("Olet alaikäinen")
# Jos käyttäjä ei ollut alaikäinen, varmistetaan onko hän 18 ja onko hän alle 65.
elif (ika >= 18) and (ika < 65):
    print("Olet aikuinen")
# Mikäli ikä on 65 tai yli, käyttäjä on seniori.
elif ika >= 65:
    print("Olet seniori")
# Muussa tapauksessa tulostetaan virheilmoitus.
else:
    print("Jokin meni pieleen. Yritä uudelleen tai ilmoita ylläpidolle.")

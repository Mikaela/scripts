"""
Kirjoita ohjelma joka
Tulostaa Tervetuloa
Seuraavaksi # olen nimi olen ikä
Seuraavaksi ohjelmaan pitää syöttää nimi ja ikä
Tulostus syötetty nimi ja ikä
Kolmas tulostus
ikä tarkistus
"""

# Vaaditaan virhe-poistumiseen
import sys


def main():
    """
    Pääfunktio.
    """

    print("Tervetuloa")

    nimeni = "Python3-koodinpätkä."
    ikani = int(0)

    print("Olen", ikani, "-vuotias", nimeni)
    nimi = input("Mikä sinun nimesi on?: ")
    # Odotetaan käyttäjän mahdollisesti pyrkivän syöttämään muutakin kuin numeroita ja varaudutaan asiaan
    try:
        # Tallennetaan kokonaislukuna käyttäjältä pyydetty ikä
        ika = int(input("Entä kuinka vanha olet? "))
    # Annetaan käyttäjäystävällinen virheilmoitus ja poistutaan virhekoodilla, jos käyttäjä ei syöttänyt numeroita
    except ValueError:
        print("Syötä ikäsi numeroina!")
        sys.exit(1)

    # Tulostetaan käyttäjän tiedot
    # print("Olet", nimi, "ja olen", ika, "-vuotias")
    print("Olet", ika, "-vuotias", nimi)

    # Aloitetaan kokeilemalla onko käyttäjä alle 18.
    if ika < 18:
        print("Olet alaikäinen")
    # Jos käyttäjä ei ollut alaikäinen, varmistetaan onko hän 18 ja onko hän alle 65.
    elif (ika >= 18) and (ika < 65):
        print("Olet täysi-ikäinen")
    # Mikäli ikä on 65 tai yli, käyttäjä on seniori.
    elif ika >= 65:
        print("Olet seniori")
    # Muussa tapauksessa tulostetaan virheilmoitus.
    else:
        print("Jokin meni pieleen. Yritä uudelleen.")


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan, suoritetaan pääfunktio.
if __name__ == "__main__":
    main()

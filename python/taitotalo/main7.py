"""
Sovellus arpoo luvun ja pyytää käyttäjää arvaamaan sen.
"""

# Tuodaan kirjastot random numeron myöhemmin arpomista varten.
import random


# Määritetään pääfunktio
def main():
    """
    Pääfunktio.
    """
    # Kutsutaan funktiota
    arvaa_numero()


# Määritetään tehtävänannossa vaadittu funktio.
def arvaa_numero():
    """
    Sovellus oikeasti toteutetaan täällä.
    """

    # Luodaan sattumanvaraisesti oikea vastaus tallentaen se kokonaisluvuksi.
    oikeavastaus = int(random.randrange(0, 10))
    # Luodaan muuttuja laskemaan yrityäsiä
    laskuri = 0

    # Debuggausta varten tulostetaan oikea vastaus
    # print(oikeavastaus)

    while True:

        laskuri += 1

        # Pyydetään käyttäjältä luku varautuen virheelliseen syötteeseen. Se on tärkeää muuttaa int:iksi tai muuten se on string!
        try:
            arvaus = int(input("Arvaa numero? "))
        # Virhesyötteen tapahtuessa
        except ValueError:
            print("Et antanut numeroa.")
            return

        # Jos käyttäjä arvaa oikein, poistutaan loopista
        if arvaus == oikeavastaus:
            # Poistetaan taas välilyönti
            print(
                "Onnittelut! :)\nArvasit oikein ",
                laskuri,
                ". yritykselläsi. Luku oli siis ",
                oikeavastaus,
                ".",
                sep="",
            )
            break

        # Muuten avustetaan käyttäjää antamalla vihje. Printistä myös poistetaan erottavat välilyönnit, jotka tehdään itse, jotta arvauksen ja pisteen väliin ei tule välilyöntejä
        elif arvaus < oikeavastaus:
            print("Oikea luku on suurempi kuin ", arvaus, ".", sep="")
        else:
            print("Oikea luku on pienempi kuin ", arvaus, ".", sep="")


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan, suoritetaan pääfunktio.
if __name__ == "__main__":
    main()

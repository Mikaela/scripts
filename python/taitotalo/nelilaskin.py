"""
Kysytään käyttäjältä kaksi lukua ja lasketaan summa, erotus ja tulo.
Tarkistetaan myös, ettei toinen luku ole nolla ja suoritetaan jakolasku.
"""

# Tuodaan sys-kirjasto, jotta voidaan poistua myöhemmin virhetilanteessa.
import sys


# Määritetään pääfunktio, jotta voidaan importata tämä kirjasto muualta.
def main():
    """
    Pääfunktio.
    """

    # Pyydetään käyttäjältä kaksi lukua varautuen siihen, ettei käyttäjä
    # syötä lukuja oikeassa muodossa.
    try:
        luku1 = float(input("Anna ensimmäinen luku: "))
        luku2 = float(input("Anna toinen luku: "))
    # Mikäli käyttäjä syöttää jotakin, mitä emme voi muuttaa float:iksi tai
    # int:iksi, annetaan virheilmoitus ja poistutaan virhekoodiin.
    except ValueError:
        print("Syötä luku!")
        sys.exit(1)

    # Tulostetaan laskutoimitukset. Käytetään int siisteyden vuoksi, vaikka
    # uhrataan tuki desimaalien laskemiselle.
    print(int(luku1), "+", int(luku2), "=", int(luku1 + luku2))
    print(int(luku1), "-", int(luku2), "=", int(luku1 - luku2))
    print(int(luku1), "*", int(luku2), "=", int(luku1 * luku2))

    # Varaudutaan siihen, että käyttäjä syöttää luvuksi nollan ja siinä
    # tapauksessa kieltäydytään suorittamasta tehtävää.
    if luku1 == 0 or luku2 == 0:
        print("Nollalla ei voi jakaa.")
    else:
        # print(luku1, "/", luku2, "=", (luku1 / luku2))
        print(int(luku1), "/", int(luku2), "=", (luku1 / luku2))


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan, suoritetaan
# pääfunktio.
if __name__ == "__main__":
    main()

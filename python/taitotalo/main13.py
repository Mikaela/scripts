"""
Lisää tekstiä tiedostoon
"""


def main():
    """
    Pääfunktio.
    """

    # Kysytään mitä käyttäjä haluaa kirjoittaa
    syote = input("Mitä haluaisit kirjoittaa tiedostoon? ") + "\r\n"
    # Avataan uusi.txt kirjoitustilassa. HUOM! Ylikirjoittaa edellisen
    # sisällön, käytä "a" lisätäksesi! Pylint valittaa jollei määritetä
    # merkistöä.
    with open("uusi.txt", "a", encoding="utf-8", newline="\r\n") as f:
        f.write(syote)


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan, suoritetaan
# pääfunktio.
if __name__ == "__main__":
    main()

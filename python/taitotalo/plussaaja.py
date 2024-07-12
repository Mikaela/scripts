"""
Plussataan lukuja, kunnes käyttäjä sanoo -1
"""

# Vaaditaan virhe-poistumiseen
# import sys


def main():
    """
    Pääfunktio.
    """

    # Tähän plussataan luvut
    laskuri = int(0)

    # Ikuisuuslooppi
    while True:

        # Varaudutaan virheellisiin syötteisiin
        try:
            # Pyydetään käyttäjän syötettä
            # syote = int(input("Anna luku. -1 lopettaa. "))
            syote = int(input("Anna luku. 0 lopettaa. "))

            # Poistutaan kun -1 syötetään
            # if syote == -1:
            if syote == 0:
                print("Ohjelma päättyi. Antamiesi lukujen summa oli", laskuri)
                # print("Ohjelma päättyi.")
                break

            # Lisätään syöte laskuriin
            laskuri += syote
            print("Antamiesi lukujen summa on", laskuri)

        # Jos lukua ei syötetty.
        except ValueError:
            print("Syötä luku!")


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan,
# suoritetaan pääfunktio.
if __name__ == "__main__":
    main()

"""
Tulostaa numerot 0-9
"""

# Vaaditaan virhe-poistumiseen
# import sys


def main():
    """
    Pääfunktio.
    """

    # Alustetaan kierros ennen silmukkaa ja kerrotaan moneen halutaan
    kierros = 0
    # Kohteeseen täytyy lisätä 1 tai viimeinen haluttu numero ei toistu.
    kohde = 9 + 1

    # Silmukoidaan kun kierros on alle kohteen
    while kierros < kohde:
        print("Kierros", kierros)
        # Nostetaan kierrosta, jottei silmukoida ikuisesti kierrosta 1
        kierros += 1

        # Lopuksi pysähdytään
        if kierros > kohde:
            break

    print()


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan,
# suoritetaan pääfunktio.
if __name__ == "__main__":
    main()

"""
1. Tallenna uusi salasana
2. Hae tallennettu salasana
3. Poista tallennettu salasana
4. Lopeta
Valitse toiminto (1/2/3/4):
"""

# import sqlite3
# import secrets
# Tuodaan csv kirjasto nimellä tsv, koska oikeasti käsittelen tsv tiedostoja
import csv as tsv


def main():
    """
    Pääfunktio.
    """

    print("TODO! TÄSSÄ PITÄISI OLLA TUNNISTAUTUMINEN ENSIN!")
    print("Tervetuloa \n")
    # Pysytään käynnissä:
    while True:
        # Toimintovalikko
        print(
            "Tallenna uusi salasana, valitse 1. Hae tallennettu salasana",
            "valitsemalla 2. Poista tallennettu salasana valitsemalla 3.",
            "Lopeta valitsemalla 4.",
        )

        # Vaihtoehdot
        try:
            valinta = int(input("Valinta? "))
            match valinta:
                case 1:
                    tallennasalasana()
                case 2:
                    haesalasana()
                case 3:
                    poistasalasana()
                case 4:
                    print("Ohjelma päättyy.")
                    break
                case _:
                    print("\nVirheellinen valinta.\n")
        except ValueError:
            print("Tämä valikko hyväksyy vain lukuja.")


def tallennasalasana():
    """
    Salasanan tallennus.
    """
    print("Tervetuloa salasanan tallennukseen.")
    # with open("kanta.tsv", "w", newline="\n") as kanta:
    # writer = csv.writer(f)
    # writer.writerows(someiterable)
    print("..vaikka tätä ei vielä olekaan olemassa.")


def haesalasana():
    """
    Salasanan haku.
    """

    # Avataan tiedosto kanta.tsv lukitilassa nimellä kanta.
    with open("kanta.tsv", newline="\n", encoding="utf-8") as kanta:

        # Yksinkertaistetaan kannan luku muuttujaksi.
        lukija = tsv.reader(kanta, delimiter="\t", quoting=tsv.QUOTE_NONE)

        # Kehitysvaiheessa vain luetaan koko kanta.
        for rivi in lukija:
            print(rivi)


def poistasalasana():
    """
    Salasanan poisto.
    """
    print("Salasanan poistoa ei ole vielä implementoitu.")


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan, suoritetaan
# pääfunktio.
if __name__ == "__main__":
    main()

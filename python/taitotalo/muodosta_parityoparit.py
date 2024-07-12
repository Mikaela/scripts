"""
Sovellus tekee listasta pareja
"""

# Tarvitaan parien muodostamiseen
import random

# Tuodaan paketti tabulate.
import tabulate


# Määritetään pääfunktio
def main():
    """
    Pääfunktio.
    """

    # Määritetään nimet{,2} lista
    nimet = ["Antti", "Pekka", "Esa"]
    nimet2 = ["Emmi", "Maini", "Reetta"]

    # Arvotaan nimilistoista kahdet parit.
    random_names1 = random.sample(nimet, 3)
    random_names2 = random.sample(nimet2, 3)

    # Luo tuplen, jossa zip yhdistää random_names{1,2} vastaavan kohdan
    # kanssa, jotka sitten laitetaan listaan.
    name_pairs = list(zip(random_names1, random_names2))

    print(name_pairs)

    # Tehdään taulukko nimistä, otsikkoina "Etunimi"
    table = tabulate.tabulate(
        name_pairs,
        headers=["Etunimi", "Etunimi"],
        tablefmt="github",
    )
    # Tulostetaan taulukko
    print(table)


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan,
# suoritetaan pääfunktio.
if __name__ == "__main__":
    main()

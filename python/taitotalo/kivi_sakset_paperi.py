"""
Kivi-sakset-paperi peli!
"""

# Tarvitaan tietokoneen vastauksen päättämiseksi
import random


# Määritetään pääfunktio
def main():
    """
    Pääfunktio.
    """

    # Arvotaan tietokoneen valinta
    tkvalinta = random.sample(["kivi", "sakset", "paperi"], 1)
    tkvalinta = str(tkvalinta[0])
    print(tkvalinta)
    # Pyydetään käyttäjän valinta
    valinta = input("Valitse 'kivi', 'sakset' tai 'paperi'\n")
    # print(valinta)

    # Verrataan vastauksia
    if tkvalinta == valinta:
        print("Tasapeli!", tkvalinta, "ja", valinta)
    elif tkvalinta == "kivi" and valinta == "sakset":
        print("Hävisit, kivi voittaa sakset")
    elif tkvalinta == "sakset" and valinta == "paperi":
        print("Hävisit, sakset voittaa paperin")
    elif tkvalinta == "paperi" and valinta == "kivi":
        print("Voitit, kivi voittaa paperin")
    elif tkvalinta == "sakset" and valinta == "kivi":
        print("Voitit, sakset voittavat kiven")
    elif tkvalinta == "paperi" and valinta == "sakset":
        print("Voitit, sakset voittavat paperin")
    else:
        # Tästä tuli vahingossa catch-all virheellisille syötteille, enkä ole
        # varma toteutinko kaikki skenaariot
        print("Joko tilannetta ei ole vielä toteutettu tai annoit \
virheellisen syötteen. Ilmoittaisitko ongelman kehittäjälle?")
        print("Tietokone valitsi:", tkvalinta, "syötteesi oli", valinta)


# Jos suoritamme koodia suoraan skriptistä importtauksen sijaan, suoritetaan
# pääfunktio.
if __name__ == "__main__":
    main()

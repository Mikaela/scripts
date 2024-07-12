"""
Sovellus pyytää käyttäjältä nimen, sekä viestin ja tulostaa viestin kolmesti.

"""

# Pyydetään käyttäjältä nimi ja viesti, tallennetaan samannimisiin muuttujiin
nimi = input("Nimi: ")
viesti = input("Viesti: ")

# Tulostetaan nimi ja kolmesti viesti rivinvaihdolla. Lopuksi poistetaan
# rivinvaihto ja erotin tulostuksesta
print(nimi, " sanoo:\n", (viesti + "\n") * 3, end="", sep="")

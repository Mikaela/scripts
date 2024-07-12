"""
Tämän skriptin olisi tarkoitus piirtää Suomen lippu turtle-kirjastolla,
mutta en koskaan tehnyt siitä valmista.
"""

# Tuodaan turtle -kirjasto
# Satunnaislukuja
# import random
import turtle

# ikkkuna = turtle.Screen()

# Asetetaan turtlen väriksi "meripihka"
turtle.pencolor("#002F6C")

# Asetetaan taustaväriksi "AMOLED" musta
# turtle.bgcolor("#000000")

# valkoinen
turtle.bgcolor("#FFFFFF")

# Asetetaan kilpikonnan muoto
turtle.shape("turtle")

# Näytetään kilpikonna liikkumatta
turtle.showturtle()

# koko = 100

# roikealle = 250
# rvasemmalle = 250
# rylos = 100

# Aletaampa liikkua
# Risti oikealle
# turtle.forward(roikealle)
# turtle.left(90)
# Risti ylös
# turtle.forward(rylos)
# turtle.left(90)
# Risti vasemmalle
# turtle.forward(rvasemmalle)
# turtle.right(90)
# Risti ylös
# turtle.forward(rylos)
# turtle.forward(50)
# Vasen
# turtle.left(90)
# turtle.forward(50)
# Alas
# turtle.left(90)
# turtle.forward(rylos)


# Piirretään suorakulmio
VAAKA = 300
PYSTY = 200
#
turtle.forward(VAAKA)
turtle.left(90)
turtle.forward(PYSTY)
#
turtle.left(90)
turtle.forward(VAAKA)
#
turtle.left(90)
turtle.forward(PYSTY)
turtle.left(90)

# Piirretään risti
turtle.forward(VAAKA / 2)
turtle.left(90)
turtle.forward(PYSTY / 3)

turtle.right(90)
turtle.forward(VAAKA / 3)
turtle.left(90)

turtle.forward(VAAKA / 5)
turtle.left(90)
turtle.forward(VAAKA / 3)

turtle.right(90)
turtle.forward(VAAKA / 3)

# turtle.forward(PYSTY / 3)

# Pidetään ikkuna auki
turtle.mainloop()

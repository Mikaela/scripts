# Tuodaan turtle -kirjasto
import turtle

# Satunnaislukuja
import random

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
vaaka = 300
pysty = 200
#
turtle.forward(vaaka)
turtle.left(90)
turtle.forward(pysty)
#
turtle.left(90)
turtle.forward(vaaka)
#
turtle.left(90)
turtle.forward(pysty)
turtle.left(90)

# Piirretään risti
turtle.forward(vaaka / 2)
turtle.left(90)
turtle.forward(pysty / 3)

turtle.right(90)
turtle.forward(vaaka / 3)
turtle.left(90)

turtle.forward(vaaka / 5)
turtle.left(90)
turtle.forward(vaaka / 3)

turtle.right(90)
turtle.forward(vaaka / 3)

# turtle.forward(pysty / 3)

# Pidetään ikkuna auki
turtle.mainloop()

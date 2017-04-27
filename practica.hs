data Cancion = UnaCancion String Int String deriving (Show)
data Disco = UnDisco String String [Cancion] deriving (Show)

pepe = UnaCancion "Pepe" 59 "Pepin"
stairwayToHeaven = UnaCancion "Starway to Heaven" 651 "Led Zeppelin"
zombie = UnaCancion "Zombie" 315 "The Cranberries"
californication = UnaCancion "Californication" 321 "Red Hot Chili Peppers"
losingMyReligion = UnaCancion "Losing My Religion" 294 "R.E.M"
whatsUp = UnaCancion "What's Up" 299 "4 Non Blondes"
wonderwall = UnaCancion "Wonderwall" 278 "Oasis"
bitterSweetSymphony = UnaCancion "Bitter Sweet Symphony" 278 "The Verve"
heartShapedBox = UnaCancion "Heart Shaped Box" 285 "Nirvana"

pepeblues = UnaCancion "Pepeblues" 120 "Pepin"
juntosAlaPar = UnaCancion "Juntos a la Par" 164 "Pappo"
longchampsBoogieblues = UnaCancion "Longchamps Boogie" 309 "Pappo"
miViejablues = UnaCancion "Mi Vieja" 156 "Pappo"
ruta66 = UnaCancion "Ruta 66" 184 "Pappo"

pepeclassics = UnDisco "Pepe Classics" "Sony Records" [pepe, pepeblues,stairwayToHeaven,zombie,californication,losingMyReligion,whatsUp,wonderwall,bitterSweetSymphony,heartShapedBox]
pepeclassics2 = UnDisco "Pepe Classics 2" "Sony Records" [pepeblues,stairwayToHeaven,losingMyReligion,whatsUp,bitterSweetSymphony,heartShapedBox]
pepeclassicblues = UnDisco "Pepe Classic Blues" "Sony Records" [pepeblues, juntosAlaPar, longchampsBoogieblues, miViejablues, ruta66]

esAnonima (UnaCancion _ _ autor) = length autor == 0
esInterludio (UnaCancion _ tiempo _) = tiempo > 60
hacerCover (UnaCancion nombre tiempo autor) autorCover = UnaCancion (nombreCover nombre autor) tiempo autorCover
nombreCover titulo autor= titulo ++ "- Cover de "  ++ autor
nombreRemix titulo autor= titulo ++ "- Remix por "  ++ autor
esBlues (UnaCancion nombre _ _) = (take 5 (reverse nombre))== "seulb"
hacerRemix (UnaCancion nombre tiempo autor) autorRemix = UnaCancion (nombreRemix nombre autorRemix) (2*tiempo) autor

esLargo disco =  cantidadTemasLargos disco esInterludio > 9
esEP disco = cantidadDeTemas disco < 9 && cantidadDeTemas disco > 4 && cantidadTemasLargos disco esInterludio > 1
esBlusero disco = cantidadDeTemas disco == cantidadTemasLargos disco esBlues
cantidadTemasLargos (UnDisco _ _ temas) f = length (filter f temas)
cantidadDeTemas (UnDisco _ _ temas) = length temas
--libreDeInterludios (UnDisco _ _ temas)  = filter esInterludio temas
arrancaConIntro disco = not(esInterludio (primerTema disco))
primerTema (UnDisco _ _ temas) = head temas
--remixarDisco (UnDisco nombre disquera temas) autorRemix = UnDisco (nombreRemix nombre autorRemix) disquera ()

--hacerCover cancion autorCover = UnaCancion (nombreCover nombre autor) tiempo autorCover
--cambioAutor (UnaCancion _ _ autor) =
--cambioAutor (UnaCancion nombre tiempo autor) autorCover = UnaCancion nombre tiempo autorCover

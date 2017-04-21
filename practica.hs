data Cancion = UnaCancion String Int String deriving (Show)
data Disco = UnDisco String String [Cancion]

pepe = UnaCancion "Pepe" 120 "Pepin"
pepe1 = UnaCancion "Pepe" 120 "Pepin"
pepe2 = UnaCancion "Pepe" 120 "Pepin"
pepe3 = UnaCancion "Pepe" 120 "Pepin"
pepe4 = UnaCancion "Pepe" 120 "Pepin"
pepe5 = UnaCancion "Pepe" 120 "Pepin"
pepe6 = UnaCancion "Pepe" 120 "Pepin"
pepe7 = UnaCancion "Pepe" 120 "Pepin"
pepe8 = UnaCancion "Pepe" 120 "Pepin"

pepeblues = UnaCancion "Pepeblues" 120 "Pepin"
pepeblues1 = UnaCancion "Pepeblues" 120 "Pepin"
pepeblues2 = UnaCancion "Pepeblues" 120 "Pepin"
pepeblues3 = UnaCancion "Pepeblues" 120 "Pepin"
pepeblues4 = UnaCancion "Pepeblues" 120 "Pepin"

pepeclassics = UnDisco "Pepeclassics" "Sony Records" [pepe, pepeblues,pepe1,pepe2,pepe3,pepe4,pepe5,pepe6,pepe7,pepe8]
pepeclassicblues = UnDisco "Pepeclassicblues" "Sony Records" [pepeblues, pepeblues1, pepeblues2, pepeblues3, pepeblues4]

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

--hacerCover cancion autorCover = UnaCancion (nombreCover nombre autor) tiempo autorCover
--cambioAutor (UnaCancion _ _ autor) = 
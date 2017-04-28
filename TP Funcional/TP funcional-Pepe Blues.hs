{- Modelamos el tipo de dato cliente utilizando un tipo data con un String para el nombre, un Int para la resistencia y 
una lista conformada por el mismo tipo data para representar a los amigos del cliente-}
data Cliente = UnCliente String Int [Cliente] deriving (Show, Eq)

--Punto 2
rodri = UnCliente "Rodri" 55 []
marcos = UnCliente "Marcos" 40 [rodri]
cristian = UnCliente "Cristian" 2 []
ana = UnCliente "Ana" 120 [marcos, rodri]
--Punto 5 reemplazar
amigos (UnCliente _ _ a) = a

grogXD (UnCliente n _ a) = UnCliente n 0 a
jarraLoca (UnCliente n r a) = UnCliente n (r-10) (map jarraLocaCompartida a)
jarraLocaCompartida (UnCliente n r a) = UnCliente n (r-10) a
klusener sabor (UnCliente n r a) = UnCliente n (r-cantidadDeElementos sabor) a
tintico (UnCliente n r a) = UnCliente n (resistenciaPorAmistad r a) a
soda fuerza (UnCliente n r a) = UnCliente (agregarANombre fuerza n) r a

--Punto 3
comoEsta cliente 
 |estaFresco cliente = "fresco"
 |tieneAmigos cliente = "piola"
 |otherwise = "duro"


estaFresco (UnCliente _ r _) = r>50
tieneAmigos (UnCliente _ _ a) = (length a)>1
cantidadDeElementos = length
agregarANombre numero nombre = "e"++(replicate numero 'r')++"p"++nombre
resistenciaPorAmistad resistencia amigos = resistencia+5*cantidadDeElementos amigos
--Punto 6
rescatarse horas (UnCliente n r a) = UnCliente n (r+recuperarResistencia horas) a
recuperarResistencia tiempo
 |tiempo>3 = 200
 |otherwise = 100
--Punto 4
hacerAmistad cliente1 cliente2
 |verificarAmistad cliente1 cliente2 = cliente1
 |otherwise = (agregarAmigo cliente1 cliente2)

verificarAmistad cliente1 cliente2 = cliente1==cliente2 || elem cliente2(amigos cliente1)
agregarAmigo (UnCliente n1 r1 a1) (UnCliente n2 r2 a2) = UnCliente n1 r1 ((UnCliente n2 r2 a2):a1)

{- Itinerario ana en consola:
  (jarraLoca.(klusener "chocolate").(rescatarse 2).(klusener "huevo")) ana 
 -}
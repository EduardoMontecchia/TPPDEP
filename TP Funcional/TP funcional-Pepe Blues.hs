{- Modelamos el tipo de dato cliente utilizando un tipo data con un String para el nombre, un Int para la resistencia y 
una lista conformada por el mismo tipo data para representar a los amigos del cliente-}

--Punto 1
data Cliente = UnCliente String Int [Cliente] deriving (Show, Eq)

--Punto 2
rodri = UnCliente "Rodri" 55 []
marcos = UnCliente "Marcos" 40 [rodri]
cristian = UnCliente "Cristian" 2 []
ana = UnCliente "Ana" 120 [marcos, rodri]

--Punto 3
comoEsta::Cliente->String
comoEsta cliente 
 |estaFresco cliente = "fresco"
 |tieneAmigos cliente = "piola"
 |otherwise = "duro"

estaFresco::Cliente->Bool
estaFresco (UnCliente _ r _) = r>50

tieneAmigos::Cliente->Bool
tieneAmigos (UnCliente _ _ a) = (length a)>1

--Punto 4
hacerAmistad::Cliente->Cliente->Cliente
hacerAmistad cliente1 cliente2
 |verificarAmistad cliente1 cliente2 = cliente1
 |otherwise = (agregarAmigo cliente1 cliente2)

verificarAmistad::Cliente->Cliente->Bool
verificarAmistad cliente1 cliente2 = cliente1==cliente2 || elem cliente2(amigos cliente1)

agregarAmigo::Cliente->Cliente->Cliente
agregarAmigo (UnCliente n1 r1 a1) (UnCliente n2 r2 a2) = UnCliente n1 r1 ((UnCliente n2 r2 a2):a1)

--Punto 5
amigos::Cliente->[Cliente] 
amigos (UnCliente _ _ a) = a

grogXD::Cliente->Cliente
jarraLoca::Cliente->Cliente
jarraLocaCompartida::Cliente->Cliente
klusener::String->Cliente->Cliente
tintico::Cliente->Cliente
soda::Int->Cliente->Cliente 

grogXD (UnCliente n _ a) = UnCliente n 0 a
jarraLoca (UnCliente n r a) = UnCliente n (r-10) (map jarraLocaCompartida a)
jarraLocaCompartida (UnCliente n r a) = UnCliente n (r-10) a
klusener sabor (UnCliente n r a) = UnCliente n (r-length sabor) a
tintico (UnCliente n r a) = UnCliente n (resistenciaPorAmistad r a) a
soda fuerza (UnCliente n r a) = UnCliente (agregarANombre fuerza n) r a

agregarANombre::Int->String->String
agregarANombre numero nombre = "e"++(replicate numero 'r')++"p"++nombre

resistenciaPorAmistad::Int->[Cliente]->Int
resistenciaPorAmistad resistencia amigos = resistencia+5*length amigos

--Punto 6
rescatarse::Int->Cliente->Cliente
rescatarse horas (UnCliente n r a) = UnCliente n (r+recuperarResistencia horas) a

recuperarResistencia::Int->Int
recuperarResistencia tiempo
 |tiempo>3 = 200
 |otherwise = 100

--Punto 7
{- Itinerario ana en consola:
  (jarraLoca.(klusener "chocolate").(rescatarse 2).(klusener "huevo")) ana 
 -}

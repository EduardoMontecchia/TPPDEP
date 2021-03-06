{- Modelamos el tipo de dato cliente utilizando un tipo data con un String para el nombre, un Int para la resistencia y 
una lista conformada por el mismo tipo data para representar a los amigos del cliente-}
data Cliente = UnCliente String Int [Cliente] deriving (Show, Eq)
data Bebida = UnaBebida String (Cliente->Cliente)

--Punto 2
rodri = UnCliente "Rodri" 55 []
marcos = UnCliente "Marcos" 40 [rodri]
cristian = UnCliente "Cristian" 2 []
ana = UnCliente "Ana" 120 [marcos, rodri]
--Punto 5
grogXD = UnaBebida "Grog XD" efectoGrogXD
jarraLoca = UnaBebida "Jarra Loca" efectoJarraLoca
klusener sabor = UnaBebida "Klusener" (efectoKlusener sabor)
tintico = UnaBebida "tintico" efectoTintico
soda fuerza = UnaBebida "soda" (efectoSoda fuerza)

amigos (UnCliente _ _ a) = a

efectoGrogXD (UnCliente n _ a) = UnCliente n 0 a
efectoJarraLoca (UnCliente n r a) = UnCliente n (r-10) (map efectoJarraLoca a)
efectoKlusener sabor (UnCliente n r a) = UnCliente n (r-cantidadDeElementos sabor) a
efectoTintico (UnCliente n r a) = UnCliente n (resistenciaPorAmistad r a) a
efectoSoda fuerza (UnCliente n r a) = UnCliente (agregarANombre fuerza n) r a

tomarBebida (UnaBebida _ efecto) cliente = efecto$cliente
--Punto 3
comoEsta cliente 
 |estaFresco cliente = "fresco"
 |tieneAmigos cliente = "piola"
 |otherwise = "duro"


estaFresco (UnCliente _ r _) = r>50
tieneAmigos (UnCliente _ _ a) = (length a)>1
cantidadDeElementos lista  = length lista
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
  (tomarBebida jarraLoca.tomarBebida (klusener "chocolate").rescatarse 2.tomarBebida (klusener "huevo"))-}

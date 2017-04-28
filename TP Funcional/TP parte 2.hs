{- Modelamos el tipo de dato cliente utilizando un tipo data con un String para el nombre, un Int para la resistencia y una lista conformada por el mismo tipo data para representar a los amigos del cliente-}
import Text.Show.Functions
data Cliente = UnCliente String Int [Cliente] [Bebida] deriving (Eq)
data Bebida = UnaBebida String (Cliente->Cliente) deriving (Eq)

--Punto 2
rodri = UnCliente "Rodri" 55 [] [tintico]
marcos = UnCliente "Marcos" 40 [rodri] [(klusener "guinda")]
cristian = UnCliente "Cristian" 2 [] [grogXD, jarraLoca]
ana = UnCliente "Ana" 120 [marcos, rodri] []
--Punto 5
grogXD = UnaBebida "Grog XD" efectoGrogXD
jarraLoca = UnaBebida "Jarra Loca" efectoJarraLoca
klusener sabor = UnaBebida "Klusener" (efectoKlusener sabor)
tintico = UnaBebida "tintico" efectoTintico
soda fuerza = UnaBebida "soda" (efectoSoda fuerza)

amigos (UnCliente _ _ a _) = a

efectoGrogXD (UnCliente n _ a b) = UnCliente n 0 a b
efectoJarraLoca (UnCliente n r a b) = UnCliente n (r-10) (map efectoJarraLoca a) b
efectoKlusener sabor (UnCliente n r a b) = UnCliente n (r-cantidadDeElementos sabor) a b
efectoTintico (UnCliente n r a b) = UnCliente n (resistenciaPorAmistad r a) a b
efectoSoda fuerza (UnCliente n r a b) = UnCliente (agregarANombre fuerza n) r a b

tomarBebida (UnaBebida _ efecto) cliente = efecto$cliente
--Punto 3
comoEsta cliente 
 |estaFresco cliente = "fresco"
 |tieneAmigos cliente = "piola"
 |otherwise = "duro"


estaFresco (UnCliente _ r _ _) = r>50
tieneAmigos (UnCliente _ _ a _) = (length a)>1
cantidadDeElementos lista  = length lista
agregarANombre numero nombre = "e"++(replicate numero 'r')++"p"++nombre
resistenciaPorAmistad resistencia amigos = resistencia+5*cantidadDeElementos amigos
--Punto 6
rescatarse horas (UnCliente n r a b) = UnCliente n (r+recuperarResistencia horas) a b
recuperarResistencia tiempo
 |tiempo>3 = 200
 |otherwise = 100
--Punto 4
hacerAmistad cliente1 cliente2
 |verificarAmistad cliente1 cliente2 = cliente1
 |otherwise = (agregarAmigo cliente1 cliente2)

verificarAmistad cliente1 cliente2 = cliente1==cliente2 || elem cliente2(amigos cliente1)
agregarAmigo (UnCliente n1 r1 a1 b1) (UnCliente n2 r2 a2 b2) = UnCliente n1 r1 ((UnCliente n2 r2 a2 b2):a1) b1

{- Itinerario ana en consola:
  (tomarBebida jarraLoca.tomarBebida (klusener "chocolate").rescatarse 2.tomarBebida (klusener "huevo"))-}
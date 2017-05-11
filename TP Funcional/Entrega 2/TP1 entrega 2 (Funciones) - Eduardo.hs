
{- Modelamos el tipo de dato cliente utilizando un tipo data con un String para el nombre, un Int para la resistencia y 
una lista conformada por el mismo tipo data para representar a los amigos del cliente-}
import Text.Show.Functions
--Punto 1
data Cliente = UnCliente String Int [Cliente] [(Cliente -> Cliente)] deriving (Show)

--Punto 2
rodri = UnCliente "Rodri" 55 [] [grogXD, jarraLoca]
marcos = UnCliente "Marcos" 40 [rodri] []
cristian = UnCliente "Cristian" 2 [] []
ana = UnCliente "Ana" 120 [marcos, rodri] []

--Punto 3
comoEsta::Cliente->String
comoEsta cliente 
 |estaFresco cliente = "fresco"
 |tieneAmigos cliente = "piola"
 |otherwise = "duro"

estaFresco::Cliente->Bool
estaFresco (UnCliente _ r _ _) = r>50

tieneAmigos::Cliente->Bool
tieneAmigos (UnCliente _ _ a _) = (length a)>1

--Punto 4
hacerAmistad::Cliente->Cliente->Cliente
hacerAmistad cliente1 cliente2
 |verificarAmistad cliente1 cliente2 = cliente1
 |otherwise = (agregarAmigo cliente1 cliente2)

verificarAmistad::Cliente->Cliente->Bool
verificarAmistad cliente1 cliente2 = (nombre cliente1)==(nombre cliente2) || elem (nombre cliente2) (map nombre (amigos cliente1))
nombre (UnCliente n _ _ _) = n

agregarAmigo::Cliente->Cliente->Cliente
agregarAmigo (UnCliente n1 r1 a1 b1) (UnCliente n2 r2 a2 b2) = UnCliente n1 r1 ((UnCliente n2 r2 a2 b2):a1) b1

--Punto 5
amigos::Cliente->[Cliente] 
amigos (UnCliente _ _ a _) = a

grogXD::Cliente->Cliente
jarraLoca::Cliente->Cliente
jarraLocaCompartida::Cliente->Cliente
klusener::String->Cliente->Cliente
tintico::Cliente->Cliente
soda::Int->Cliente->Cliente 

grogXD (UnCliente n _ a b) = UnCliente n 0 a b
jarraLoca (UnCliente n r a b) = UnCliente n (r-10) (map jarraLocaCompartida a) b
jarraLocaCompartida (UnCliente n r a b) = UnCliente n (r-10) a b
klusener sabor (UnCliente n r a b) = UnCliente n (r-length sabor) a b
tintico (UnCliente n r a b) = UnCliente n (resistenciaPorAmistad r a) a b
soda fuerza (UnCliente n r a b) = UnCliente (agregarANombre fuerza n) r a b

agregarANombre::Int->String->String
agregarANombre numero nombre = "e"++(replicate numero 'r')++"p"++nombre

resistenciaPorAmistad::Int->[Cliente]->Int
resistenciaPorAmistad resistencia amigos = resistencia+5*length amigos

--Punto 6
rescatarse::Int->Cliente->Cliente
rescatarse horas (UnCliente n r a b) = UnCliente n (r+recuperarResistencia horas) a b

recuperarResistencia::Int->Int
recuperarResistencia tiempo
 |tiempo>3 = 200
 |otherwise = 100

--Punto 7
{- Itinerario ana en consola:
  (jarraLoca.(klusener "chocolate").(rescatarse 2).(klusener "huevo")) ana 
 -}
 
  --SEGUNDA ENTREGA
 
tomarTragos (UnCliente n r a b) (bebida:bebidas) = foldl tomar (tomar (UnCliente n r a b) bebida) bebidas

tomar (UnCliente n r a b) bebida = bebida (UnCliente n r a (bebida:b))

dameOtro cliente = tomar cliente (ultimabebida cliente)

--Si no usamos la funcion ultimabebida salta error
cualesPuedeTomar (UnCliente n r a b) bebidas= map (ultimabebida) (filter (mayor) (mapearBebidas (UnCliente n r a b) bebidas))

ultimabebida (UnCliente _ _ _ b) = last b

mayor (UnCliente _ r _ b) | r>0 = True
                          | otherwise = False

mapearBebidas cliente bebidas = map (tomar cliente) bebidas

cuantasPuedeTomar cliente bebidas = length (cualesPuedeTomar cliente bebidas)

{-  --SEGUNDA ENTREGA
 
data Itinerario = UnItinerario String Float [(Cliente->Cliente)] deriving (Show)
mezclaExplosiva = UnItinerario "Mezcla Explosiva" 2.5 [grogXD, grogXD, klusener "huevo", klusener "frutilla"]
itinerarioBasico = UnItinerario "Itinerario Básico" 5 [jarraLoca, klusener "chocolate", rescatarse 2, klusener "huevo"]
salidaDeAmigos = UnItinerario "Salida de Amigos" 1 [soda 1, tintico, agregarAmigo robertoCarlos, jarraLoca]
hacerItinerario (UnItinerario _ _ i) cliente = tomarTragos cliente i
tomar (UnCliente n r a b) bebida= bebida (UnCliente n r a (bebida:b))
tomarTragos (UnCliente n r a b) (bebida:bebidas) = foldl tomar (tomar (UnCliente n r a b) bebida) bebidas
dameOtro cliente = tomar cliente (ultimabebida cliente)
cualesPuedeTomar cliente bebidas= map (ultimabebida) (filter (mayor) (mapearBebidas (cliente) bebidas))
ultimabebida (UnCliente _ _ _ b) = last b
mayor (UnCliente _ r _ b) | r>0 = True
                          | otherwise = False
mapearBebidas cliente bebidas = map (tomar cliente) bebidas
cuantasPuedeTomar cliente bebidas= length (cualesPuedeTomar cliente bebidas) 
-}

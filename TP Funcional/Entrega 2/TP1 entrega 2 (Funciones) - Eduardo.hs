{- Modelamos el tipo de dato cliente utilizando un tipo data con un String para el nombre, un Int para la resistencia y 
una lista conformada por el mismo tipo data para representar a los amigos del cliente-}
import Text.Show.Functions
import Data.List

--Punto 1
data Cliente = UnCliente String Int [Cliente] [Cliente -> Cliente] deriving (Show)

--Punto 2
rodri = UnCliente "Rodri" 55 [] [tintico]
marcos = UnCliente "Marcos" 40 [rodri] [klusener "guinda"]
cristian = UnCliente "Cristian" 2 [] [grogXD, jarraLoca]
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
 |otherwise = (agregarAmigo cliente2 cliente1)

verificarAmistad::Cliente->Cliente->Bool
verificarAmistad cliente1 cliente2 = (nombre cliente1)==(nombre cliente2) || elem (nombre cliente2) (map nombre (amigos cliente1))
nombre (UnCliente n _ _ _) = n

agregarAmigo::Cliente->Cliente->Cliente
--El primer cliente se agrega como amigo al segundo
agregarAmigo unAmigo (UnCliente n1 r1 a1 b1) = UnCliente n1 r1 (unAmigo:a1) b1 

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
 
--Punto 1
tomarTragos :: Cliente -> [Cliente->Cliente] -> Cliente
tomarTragos cliente bebidas = foldl tomar cliente bebidas
tomar :: Cliente -> (Cliente->Cliente) -> Cliente
tomar (UnCliente n r a b) bebida = bebida (UnCliente n r a (agregarTrago bebida b))
agregarTrago :: (Cliente->Cliente) -> [Cliente->Cliente] -> [Cliente->Cliente]
agregarTrago bebida bebidas = bebidas ++ [bebida]

dameOtro :: Cliente -> Cliente
dameOtro cliente = tomar cliente (ultimabebida cliente)
ultimabebida :: Cliente -> (Cliente -> Cliente)
ultimabebida (UnCliente _ _ _ b) = last b

--Punto 2
cualesPuedeTomar :: Cliente -> [Cliente -> Cliente] -> [Cliente -> Cliente]
cualesPuedeTomar cliente bebidas = filter (puedeTomar cliente) bebidas
puedeTomar :: Cliente -> (Cliente -> Cliente) -> Bool
puedeTomar cliente bebida = resistencia (tomar cliente bebida) > 0
cuantasPuedeTomar :: Cliente -> [Cliente -> Cliente] -> Int
cuantasPuedeTomar cliente bebidas = length (cualesPuedeTomar cliente bebidas)

--Punto 3
data Itinerario = UnItinerario String Float [(Cliente->Cliente)] deriving (Show)

robertoCarlos = UnCliente "Roberto Carlos" 165 [] []

mezclaExplosiva = UnItinerario "Mezcla Explosiva" 2.5 [grogXD, grogXD, klusener "huevo", klusener "frutilla"]
itinerarioBasico = UnItinerario "Itinerario Básico" 5 [jarraLoca, klusener "chocolate", rescatarse 2, klusener "huevo"]
salidaDeAmigos = UnItinerario "Salida de Amigos" 1 [soda 1, tintico, agregarAmigo robertoCarlos, jarraLoca]
hacerItinerario (UnItinerario _ _ i) cliente = tomarTragos cliente i

--Punto 4
intensidad :: Itinerario -> Float
intensidad (UnItinerario _ t a) = (genericLength a)/t
elMasIntenso :: Cliente -> [Itinerario] -> Cliente
elMasIntenso cliente itinerarios = hacerItinerario (masIntenso itinerarios) cliente
masIntenso :: [Itinerario] -> Itinerario
masIntenso (itinerario:itinerarios) = foldl (intensoEntre2) itinerario itinerarios
intensoEntre2 :: Itinerario -> Itinerario -> Itinerario
intensoEntre2 itinerario1 itinerario2 | intensidad itinerario1 > intensidad itinerario2 = itinerario1
                                      | otherwise = itinerario2

--Punto 5
chuckNorris = UnCliente "Chuck" 1000 [ana] [soda x|x<-[1..]]

-- Si usamos la funcion dameOtro con chuckNorris nunca termina de generar el nombre por lo que falla la ejecución.

-- Aplicando en consola la expresion " resistencia chuckNorris > resistencia ana " compara y muestra correctamente que es verdadero.
resistencia :: Cliente -> Int
resistencia (UnCliente _ r _ _) = r

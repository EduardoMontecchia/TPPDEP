
-- Utilizamos un data porque el cliente consta de varios datos y a su vez por medio de un data se puede ver de manera mas especifica
-- que datos posee en este caso el cliente -- 

-- Punto 1 --

data Cliente = Cliente {nombre :: String, resistencia :: Int, amigos :: [Cliente]} deriving (Show,Eq)

-- Punto 2 -- 

rodri = Cliente {nombre = "Rodri", resistencia = 55, amigos = []}

marcos = Cliente {nombre = "Marcos", resistencia = 40, amigos = [rodri]}

cristian = Cliente {nombre = "Cristian", resistencia = 2, amigos = []}

ana = Cliente {nombre = "Ana", resistencia = 120, amigos = [marcos,rodri]}

-- Punto 3 --

comoEsta cliente | estaFresco cliente = "fresco"
                 | not (estaFresco cliente) && tieneMasDeUnAmigo cliente = "piola"
                 | otherwise = "duro"

resistenciaCliente (Cliente nombre resistencia amigos) = resistencia

estaFresco cliente = resistenciaCliente cliente > 50

amigosCliente (Cliente nombre resistencia amigos) = amigos 

tieneMasDeUnAmigo cliente = length (amigosCliente cliente) > 1

nombreCliente (Cliente nombre resistencia amigos) = nombre

-- Punto 4 --

amigoEstaEnMiLista cliente amigo = elem amigo (amigosCliente cliente)

reconocerAmigo cliente amigo | not((amigoEstaEnMiLista cliente amigo) || (nombreCliente cliente == nombreCliente amigo)) = amigosCliente cliente ++ [amigo]
                             | otherwise = amigosCliente cliente


-- Punto 5 --

data Bebida = Bebida {nombreBebida :: String, gusto :: String} deriving (Show,Eq)

grogXD = Bebida {nombreBebida = "grog XD", gusto = ""}
jarraLoca = Bebida {nombreBebida = "jarra Loca", gusto = ""}
klusenerDeHuevo = Bebida {nombreBebida = "klusener De Huevo", gusto = "Huevo"}
klusenerDeChocolate = Bebida {nombreBebida = "klusener De Chocolate", gusto = "Chocolate"}
tintico = Bebida {nombreBebida = "tintico", gusto = ""}

longitudGustoBebida (Bebida nombreBebida gusto) = length gusto

bajarResistenciaAmigo (Cliente nombre resistencia amigos) = (Cliente nombre (resistencia - 10) amigos)

bajarResistenciaAmigos amigos = map (bajarResistenciaAmigo) amigos

agregarPrefijo nombre cantidadRepeticiones = "e" ++ replicate cantidadRepeticiones 'r' ++ "p" ++ nombre 

tomar bebida (Cliente nombre resistencia amigos) | bebida == grogXD = (Cliente nombre 0 amigos)
                                                 | bebida == jarraLoca = (Cliente nombre (resistencia - 10) (bajarResistenciaAmigos amigos))
                                                 | bebida == klusenerDeHuevo = (Cliente nombre (resistencia - longitudGustoBebida(klusenerDeHuevo)) amigos)
                                                 | bebida == klusenerDeChocolate = (Cliente nombre (resistencia - longitudGustoBebida(klusenerDeChocolate)) amigos)
                                                 | bebida == tintico = (Cliente nombre (resistencia + (5 * length amigos)) amigos)

tomarSoda fuerza (Cliente nombre resistencia amigos) = (Cliente (agregarPrefijo nombre fuerza) resistencia amigos)

-- Punto 6 --

rescatarse tiempoEnHoras (Cliente nombre resistencia amigos) | tiempoEnHoras > 3 = (Cliente nombre (resistencia + 200) amigos)
                                                             | tiempoEnHoras > 0 && tiempoEnHoras <= 3 = (Cliente nombre (resistencia + 100) amigos)

-- Punto 7 --
itinerario cliente = tomar klusenerDeHuevo (rescatarse 2 (tomar klusenerDeChocolate (tomar jarraLoca cliente)))
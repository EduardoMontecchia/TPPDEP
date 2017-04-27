data Cliente = UnCliente String Int [Cliente] deriving (Show, Eq)

rodri = UnCliente "Rodri" 55 []
marcos = UnCliente "Marcos" 40 [rodri]
cristian = UnCliente "Cristian" 2 []
ana = UnCliente "Ana" 120 [marcos, rodri]

resistencia (UnCliente _ res _ ) = res
cantAmigos (UnCliente _ _ ami ) = length ami
comoEsta cliente
                | (resistencia cliente) > 50 = "Fresco"
                | (cantAmigos cliente) >= 1 = "Piola"
                | otherwise = "Duro"
suPropioAmigo (UnCliente nom _ _) (UnCliente nomami _ _) = nomami==nom
esAmigo (UnCliente _ _ ami) amigo = (elem amigo) ami
sumarAmigo (UnCliente nom res ami) amigo = (UnCliente nom res (ami ++ amigo)) 
agregarAmigo cliente amigo
                | suPropioAmigo cliente amigo= cliente
                | esAmigo cliente amigo = cliente
                | otherwise = cliente -- sumarAmigo cliente amigo
tomar bebida cliente = bebida cliente
grogXD (UnCliente nom res ami) = (UnCliente nom (res-res) ami)
jarraLoca (UnCliente nom res ami) = (UnCliente nom (res-10) (map (jarraCompartida) ami))
jarraCompartida (UnCliente nom res ami) = (UnCliente nom (res-10) ami)
klusener (UnCliente nom res ami) gusto = (UnCliente nom (res - length gusto) ami )
tintico (UnCliente nom res ami) = (UnCliente nom (res + 5 * (length ami)) ami )
soda (UnCliente nom res ami) fuerza = (UnCliente ((erp fuerza)++nom) res ami)
erp fuerza = "e" ++ (replicate fuerza 'r') ++ "p" 
rescatarse :: Cliente -> Int -> Cliente
rescatarse (UnCliente nom res ami) horas 
                |horas<=0 = (UnCliente nom res ami)
                |horas<3 = (UnCliente nom (res+100) ami)
                |otherwise = (UnCliente nom (res+200) ami)

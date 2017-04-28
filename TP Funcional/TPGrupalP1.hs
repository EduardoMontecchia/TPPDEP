---------------------- Punto 1 ---------------------------
data Cliente = Uncliente String Int [Cliente] deriving (Show)
--data Listadeamigos = Unalistadeamigos [String]

---------------------- Punto 2 ---------------------------

--sinAmigo =[Unalistadeamigos []]
--modeldoDeClientes = [ Uncliente "Rodri" 55 [] ,Uncliente "Marcos" 40 ["Rodri"],Uncliente "Cristian" 2 [], Uncliente "Ana" 120 ["Marcos","Rodri"] ]
rodri = Uncliente "Rodri" 55 []
marcos = Uncliente "Marcos" 40 [rodri]
cristian = Uncliente "Cristian" 2 []
ana = Uncliente "Ana" 120 [marcos, rodri]

-----------------------Punto 3----------------------------
esPiola (Uncliente _ _ lamigos)=length lamigos>1
esFresco (Uncliente _ resistencia _)= resistencia>50

--contar valor= length valor
--contarAmigos= contar.amigosListaCli

--cliPiola cant= cant >1
--esPiola= cliPiola.contarAmigos

--cliFresco resi= resi > 50
--esFresco= cliFresco.resistenciaCli

comoEsta cliente
 |esFresco cliente  = "fresco"
 |esPiola cliente = "piola"
 |otherwise = "duro"
--type Estado = (int, int)

{- Parcial Funcional - Paradigmas de Programación
Eduardo Montecchia - 152.343-0 
-}

import Text.Show.Functions

data Personaje = UnPersonaje { vida :: Float,
                               resistencia :: Float,
                               fuerza :: Float,
                               objetos :: [(Float -> Float)]} deriving (Show)

aeris = UnPersonaje 500 500 2100 [baculoDuplicador]
sephiroth = UnPersonaje 2000 1000 2500 [espadaOxidada, katanaFilosa, dagaLambdica 50]

espadaOxidada = (1.2*)
katanaFilosa = (10+) . (0.9*)
dagaLambdica cm = ((1+cm)/100*)
anilloParadigmatico = sqrt
baculoDuplicador  x = x * 2
espadaMaldita = espadaOxidada.dagaLambdica 89
espadaLegendaria = (1*)

-- Punto 1

defensa personaje = (resistencia personaje) + (vida personaje)
ataque personaje = foldr (id) (fuerza personaje) (objetos personaje)

{- 
*Main> ataque sephiroth
1389.0
*Main> defensa sephiroth
3000.0
-}
-- Punto 2

atacar personaje1 personaje2 = personaje2 {vida = (vida personaje2) - calculoAtaque personaje1 personaje2}
calculoAtaque personaje1 personaje2 | ((ataque personaje1) - (defensa personaje2)) > 0 = ataque personaje1 - defensa personaje2
                                    | otherwise = 0

{-
*Main> atacar aeris sephiroth
UnPersonaje {vida = 800.0, resistencia = 1000.0, fuerza = 2500.0, objetos = [<function>,<function>,<function>]}
-}

-- Punto 3

convienePelear personaje1 personaje2 = ataque personaje1 < ataque (robarObjetos personaje1 personaje2)
robarObjetos personaje1 personaje2 = personaje1 {objetos = (objetos personaje1) ++ (objetos personaje2)}

{-
*Main> convienePelear aeris sephiroth
False
-}

-- Punto 4

pelear personaje1 personaje2 | vida personaje1 > 0 && vida personaje2 > 0 = flip pelear personaje1 (atacar personaje1 personaje2)
                             | otherwise = ganador personaje1 personaje2
ganador personaje1 personaje2 | vida personaje1 > vida personaje2 = robarObjetos personaje1 personaje2
                              | otherwise = robarObjetos personaje2 personaje1

{-
*Main> pelear aeris sephiroth
UnPersonaje {vida = 111.0, resistencia = 500.0, fuerza = 2100.0, objetos = [<function>,<function>,<function>,<function>]}
-}

-- Punto 5

aprendiz personaje = personaje {objetos = [combinarObjetos (objetos personaje)]}
maestroArtesano experiencia personaje = personaje {objetos = [mejorar experiencia (objetos personaje)]}
estafador personaje = personaje {objetos = [espadaLegendaria]}
-- El nuevo artesano toma el último objeto del personaje y le fabrica una gran cantidad en función de su poder para ayudarlo (en algunos casos).
nuevoArtesano poder personaje = personaje {objetos = multiplicar poder (last(objetos personaje))}
multiplicar poder objeto = replicate (10 + (poder*poder)) objeto
mejorar experiencia objetos = combinarObjetos (((experiencia*0.1)*):objetos)
combinarObjetos objetos x = foldr (id) x objetos

artesanosMayores nuevoAtaque artesanos personaje = filter (mayorAtaque personaje nuevoAtaque) artesanos
mayorAtaque personaje valor artesano = (ataque (artesano personaje)) > valor
artesanosConvienen artesanos personaje = all (mayorAtaque personaje (ataque personaje)) artesanos

{-
*Main> aprendiz sephiroth
UnPersonaje {vida = 2000.0, resistencia = 1000.0, fuerza = 2500.0, objetos = [<function>]}
*Main> maestroArtesano 10 sephiroth
UnPersonaje {vida = 2000.0, resistencia = 1000.0, fuerza = 2500.0, objetos = [<function>]}
*Main> estafador sephiroth
UnPersonaje {vida = 2000.0, resistencia = 1000.0, fuerza = 2500.0, objetos = [<function>]}
*Main> nuevoArtesano 5 sephiroth
UnPersonaje {vida = 2000.0, resistencia = 1000.0, fuerza = 2500.0, objetos = [<function>,<function>..<function>]
*Main> artesanosMayores 100 [aprendiz] sephiroth
[<function>]
*Main> artesanosConvienen [aprendiz, estafador, maestroArtesano 20] sephiroth
False
-}



-- Punto 6

infinitum = UnPersonaje 9999 9999 9999 (repetirObjetos espadaOxidada)
repetirObjetos objeto = objeto : repetirObjetos objeto

{- El personaje Infinitum puede solicitar todos los servicios individualmente, pero al usar las funciones artesanosMayores o artesanosConvienen 
nunca termina de procesar. 
Ej: "artesanosConvienen [aprendiz] infinitum" no termina nunca pues no puede terminar de calcular el ataque
*Main> estafador infinitum
UnPersonaje {vida = 9999.0, resistencia = 9999.0, fuerza = 9999.0, objetos = [<function>]}
    "estafador infinitum" finaliza correctamente pues nunca se molesta en procesar la funcion repetirObjetos dentro del personaje.
Este concepto se denomina aplicación diferida o Lazy Evaluation, donde nada es evaluado a menos que sea estrictamente necesario.
-}

-- Punto 7

{- agregarObjeto obj (Personaje a b c) = Personaje ((+ 100).a) b (\x-> obj x):c
No funciona correctamente pues falta un elemento y el constructor es diferente, la composición debe ser entre funciones y esta realizada
entre una funcion y un valor. En caso de funcionar la misma es poco expresiva, a simple vista no se
nota lo que se quiere realizar. Los nombres de las variables no son claros, por lo que no se comprende qué es lo que se está operando.
Se utilizan conceptos de constructor de tipo (el Personaje), composición de funciones, función lambda (aplicada innecesariamente) y  manejo de listas.
-}


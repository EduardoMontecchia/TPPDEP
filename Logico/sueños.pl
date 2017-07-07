%Punto 1

creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(gabriel,campanita).
creeEn(juan,conejoDePascuas).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).
suenio(gabriel,loteria([5,9])).
suenio(gabriel,futbolista(arsenal)).
suenio(juan,cantante(100000)).
suenio(macarena,cantante(10000)).
equipoChico(arsenal).
equipoChico(aldosivi). 

%Punto 2

dificultad(Persona,Dificultad):-suenio(Persona,cantante(Ventas)),dificultadVentas(Ventas,Dificultad).
dificultad(Persona,Dificultad):-suenio(Persona,loteria(Numeros)),length(Numeros,Cantidad),Dificultad is Cantidad*10.
dificultad(Persona,Dificultad):-suenio(Persona,futbolista(Equipo)),dificultadEquipo(Equipo,Dificultad).
dificultadEquipo(Equipo,3):-equipoChico(Equipo).
dificultadEquipo(Equipo,4):-not(equipoChico(Equipo)).
dificultadVentas(Ventas,6):-Ventas>500000.
dificultadVentas(Ventas,4):-Ventas=<500000.

ambicioso(Persona):-esPersona(Persona),findall(Dificultad,dificultad(Persona,Dificultad),L),sumlist(L,Ambiciones),Ambiciones>20.
esPersona(Persona):-creeEn(Persona,_).

%Punto 3

quimica(Persona,campanita):-creeEn(Persona,campanita),dificultad(Persona,Dificultad),Dificultad<5.
quimica(Persona,Personaje):-creeEn(Persona,Personaje),Personaje \= campanita,suenioPuro(Persona),not(ambicioso(Persona)).
suenioPuro(Persona):-suenio(Persona,futbolista(_)).
suenioPuro(Persona):-suenio(Persona,cantante(Ventas)),Ventas<200000.

%Punto 4

amigo(campanita,reyesMagos).
amigo(campanita,conejoDePascuas).
amigo(conejoDePascuas,cavenaghi).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascuas).

puedeAlegrar(Persona,Personaje):-suenio(Persona,_),quimica(Persona,Personaje),alegria(Personaje).
alegria(Personaje):-not(enfermo(Personaje)).
alegria(Personaje):-backup(Personaje,BackUp),not(enfermo(BackUp)).
backup(Personaje,BackUp):-amigo(Personaje,BackUp).
backup(Personaje,BackUp):-amigo(Personaje,Amigo),backup(Amigo,BackUp).
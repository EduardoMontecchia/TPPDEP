/* Parte 1 */

programa(fernando,java).
programa(fernando,cobol).
programa(fernando,visualBasic).
programa(julieta,java).
programa(marcos,java).
programa(santiago,java).
programa(santiago,ecmaScript).

cumpleRol(Persona,programador):-programa(Persona,_).
cumpleRol(fernando,analistaFuncional).
cumpleRol(andres,projectLeader).
/* 
-Aún no sabemos si Julieta programó en Go:
Al no tener certeza de si programó en Go no podemos escribir un predicado aseverándolo.

-Nadie programo en Assembler: 
Por defininicion de universo cerrado no es necesario aclarar este hecho, ya que el lengüaje al no encontrar a alguien que programe en Assembler deducirá que nadie lo hace.


--consultas
A)
?-programa(fernando,Lenguaje).
Lenguaje = java ;
Lenguaje = cobol ;
Lenguaje = visualBasic.

B)
?- programa(Persona,java).
Persona = fernando ;
Persona = julieta ;
Persona = marcos ;
Persona = santiago.

C)
?- programa(_,assembler).
false.

D)
?- cumpleRol(Fernando,programador).

E)
?- cumpleRol(fernando,Rol).
Rol = programador ;
Rol = programador ;
Rol = programador ;
Rol = analistaFuncional.

F)
cumpleRol(Persona,programador).
Persona = fernando ;
Persona = fernando ;
Persona = fernando ;
Persona = julieta ;
Persona = marcos ;
Persona = santiago ;
Persona = santiago.

G)
?- cumpleRol(_,proyectLeader).
false.

Parte 2 */

proyecto(sumatra,net).
proyecto(sumatra,java).
proyecto(prometeus,cobol).


trabajaEn(prometeus,fernando).
trabajaEn(prometeus,santiago).
trabajaEn(sumatra,julieta).
trabajaEn(sumatra,marcos).
trabajaEn(sumatra,andres).

%2

correctamenteAsignada(Persona,Proyecto):-trabajaEn(Proyecto,Persona),
                                         proyecto(Proyecto,Lenguaje),
										 programa(Persona,Lenguaje).
correctamenteAsignada(Persona,Proyecto):-trabajaEn(Proyecto,Persona),
                                         cumpleRol(Persona,analistaFuncional).
correctamenteAsignada(Persona,Proyecto):-trabajaEn(Proyecto,Persona),
                                         cumpleRol(Persona,projectLeader).
												
%3
unProyectoEsBienDefinido(Proyecto):- proyecto(Proyecto,_),
								forall(trabajaEn(Proyecto,Persona),correctamenteAsignada(Persona,Proyecto)),
								esUnicoLider(Persona,Proyecto).
								
esUnicoLider(Persona,Proyecto):-not(hayOtroLider(Persona,Proyecto)).
						
hayOtroLider(Persona,Proyecto):-trabajaEn(Proyecto,Persona),
								cumpleRol(Persona,projectLeader),
								trabajaEn(Proyecto,Persona2),
								cumpleRol(Persona2,projectLeader),
								Persona2 \= Persona.


/* 
Casos de prueba
1-
?- proyecto(sumatra,Lenguaje).
Lenguaje = net ;
Lenguaje = java.

2-
?- not((proyecto(prometeus,Lenguaje),Lenguaje \= cobol)).
true.

3-
?- trabajaEn(prometeus,fernando).
true 

4-
?- trabajaEn(prometeus,santiago).
true.

5-
?- trabajaEn(sumatra,Lapersona).
Lapersona = julieta ;
Lapersona = marcos ;
Lapersona = andres.

6-
?- correctamenteAsignada(Persona,sumatra).
Persona = julieta ;
Persona = marcos ;
Persona = andres.

7-
?- correctamenteAsignada(Persona,prometeus).
Persona = fernando ;
Persona = fernando ;
false.

-8
?- correctamenteAsignada(Persona,Proyecto).
Persona = fernando,
Proyecto = prometeus ;
Persona = julieta,
Proyecto = sumatra ;
Persona = marcos,
Proyecto = sumatra ;
Persona = fernando,
Proyecto = prometeus ;
Persona = andres,
Proyecto = sumatra.

9- 
?- correctamenteAsignada(_,Proyecto).
Proyecto = prometeus ;
Proyecto = sumatra ;
Proyecto = sumatra ;
Proyecto = prometeus ;
Proyecto = sumatra ;
Proyecto = sumatra.

Punto 3: Proyectos bien definidos

10-
?- unProyectoEsBienDefinido(Proyecto).
Proyecto = sumatra ;
Proyecto = sumatra ;
false.

11- 
?- unProyectoEsBienDefinido(prometeus).
false.

12-
?- (proyecto(Proyecto,_),not(unProyectoEsBienDefinido(Proyecto))).
Proyecto = prometeus.

*/

%Parte 3
%4
copadoCon(fernando, santiago).
copadoCon(santiago, julieta).
copadoCon(santiago, marcos).
copadoCon(julieta, andres).

puedeCoparseCon(Persona1, Persona2):- copadoCon(Persona1, Persona2).
puedeCoparseCon(Persona1, Persona2):- copadoCon(Persona1, Persona3), puedeCoparseCon(Persona3, Persona2).
puedeEnseniarUnLenguaje(Lenguaje, Persona1, Persona2):- puedeCoparseCon(Persona1, Persona2), programa(Persona1, Lenguaje), not(programa(Persona2, Lenguaje)).

%5
tarea(fernando, evolutiva(compleja)).  
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algoritmica(150)).
tarea(marcos, algoritmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)). 

puntosDeTarea(evolutiva(compleja), 5).
puntosDeTarea(evolutiva(simple), 3).
puntosDeTarea(correctiva(_, brainfuck), 4).
puntosDeTarea(correctiva(Lineas,_), 4):- Lineas>50.
puntosDeTarea(algoritmica(Lineas), Puntos):- Puntos is Lineas/10.

gradoDeSeniority(Persona, Grado):- findall(Puntos, tarea(Persona,Tarea), puntosDeTarea(Tarea,Puntos), Lista), sumlist(Lista, Grado).

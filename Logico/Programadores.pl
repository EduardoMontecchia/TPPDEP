/* parte 1 */
lenguaje(java).
lenguaje(net).
lenguaje(cobol).
lenguaje(visualBasic).
lenguaje(ecmaScript).
/* lenguaje(assembler).*/

programador(fernando,java).
programador(fernando,cobol).
programador(fernando,visualBasic).
programador(julieta,java).
programador(marcos,java).
programador(santiago,java).
programador(santiago,ecmaScript).

analistaFuncional(fernando).
projectLeader(andres).


esProgramador(Alguien):- lenguaje(X),
						programador(Alguien,X).
/* 
-aun no sabemos si julieta programo en go 
no podemos escribier un predicado porque o tenemos informacion si ulieta programa en go 

-nadie programo en Assembler
por la defininicion de universo cerado y como tenemos la informacion de quien programa cierto lenguaje sabemos que nadie prgrama en Assembler


--consultas
a
programador(fernando,Lenguaje).
Lenguaje = java ;
Lenguaje = cobol ;
Lenguaje = visualBasic.

b
?- programador(Persona,java).
Persona = fernando ;
Persona = julieta ;
Persona = marcos ;
Persona = santiago.

c
?- programador(_,assembler).
false.

d
?- esProgramador(fernando).
true

e
?- esProgramador(Persona).
Persona = fernando ;
Persona = julieta ;
Persona = marcos ;
Persona = santiago ;
Persona = fernando ;
Persona = fernando ;
Persona = santiago.

f
?- projectLeader(_).
true. */

% ----parte2

proyecto(sumatra,net).
proyecto(sumatra,java).
proyecto(prometeus,cobol).


trabajaEn(prometeus,fernando).
trabajaEn(prometeus,santiago).
trabajaEn(sumatra,julieta).
trabajaEn(sumatra,marcos).
trabajaEn(sumatra,andres).

%2

personaCorrectaEnUnProyecto(Persona,Proyecto):- trabajaEn(Proyecto,Persona),
												programador(Persona,Lenguaje),
												proyecto(Proyecto,Lenguaje).
												
personaCorrectaEnUnProyecto(Persona,Proyecto):- trabajaEn(Proyecto,Persona),
												analistaFuncional(Persona).

personaCorrectaEnUnProyecto(Persona,Proyecto):- trabajaEn(Proyecto,Persona),
												projectLeader(Persona).
												
%3
unProyectoEsDefinido(Proyecto):- proyecto(Proyecto,_),
								forall(trabajaEn(Proyecto,Persona),personaCorrectaEnUnProyecto(Persona,Proyecto)),
								esUnicoLider(Persona,Proyecto).
								
esUnicoLider(Persona,Proyecto):- projectLeader(Persona),
						not((hayOtroLider(Persona,Proyecto))).
						
hayOtroLider(Persona,Proyecto):-trabajaEn(Proyecto,Persona),
								projectLeader(Persona),
								trabajaEn(Proyecto,Persona2),
								projectLeader(Persona2),
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
?- personaCorrectaEnUnProyecto(Persona,sumatra).
Persona = julieta ;
Persona = marcos ;
Persona = andres.

7-
?- personaCorrectaEnUnProyecto(Persona,prometeus).
Persona = fernando ;
Persona = fernando ;
false.

-8
?- personaCorrectaEnUnProyecto(Persona,Proyecto).
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

9- ¿?

Punto 3: Proyectos bien definidos

10-
?- unProyectoEsDefinido(Proyecto).
Proyecto = sumatra ;
Proyecto = sumatra ;
false.

11- ¿o la pregunta es de negacion?
?- unProyectoEsDefinido(prometeus).
false.

12-
?- (proyecto(Proyecto,_),not(unProyectoEsDefinido(Proyecto))).
Proyecto = prometeus.

*/

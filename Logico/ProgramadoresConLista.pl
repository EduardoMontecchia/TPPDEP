lenguaje(java).
lenguaje(net).
lenguaje(cobol).
lenguaje(visualBasic).
lenguaje(ecmaScript).
/* lenguaje(assembler).*/

programa(fernando,java).
programa(fernando,cobol).
programa(fernando,visualBasic).
programa(julieta,java).
programa(marcos,java).
programa(santiago,java).
programa(santiago,ecmaScript).

cumpleRol(Persona,programador):- programa(Persona,_).
cumpleRol(fernando,analistaFuncional).
cumpleRol(andres,projecLeader).



/* parte 2 */

proyecto(sumatra,[java,net]).
proyecto(prometeus,[cobol]).

trabajaEn(sumatra,[julieta,marcos,andres]).
trabajaEn(prometeus,[fernando,santiago]).

personaCorrectaAsignacionEnProy(Persona,Proyecto) :- trabajaEn(Proyecto,ListPersona),
													member(Persona,ListPersona),
													proyecto(Proyecto,ListLenguaje),
													programa(Persona,Lenguaje),
													member(Lenguaje,ListLenguaje).

personaCorrectaAsignacionEnProy(Persona,Proyecto) :- trabajaEn(Proyecto,ListPersona),
													member(Persona,ListPersona),
													cumpleRol(Persona,analistaFuncional).
													
personaCorrectaAsignacionEnProy(Persona,Proyecto) :- trabajaEn(Proyecto,ListPersona),
													member(Persona,ListPersona),
													cumpleRol(Persona,projecLeader).
																									
													
unProyectoEsDefinido(Proyecto):- proyecto(Proyecto,_),
                                 trabajaEn(Proyecto,ListPersona),
								 forall(member(Persona,ListPersona),personaCorrectaAsignacionEnProy(Persona,Proyecto)),
 								 esUnicoLider(Persona,Proyecto).
								
								
esUnicoLider(Persona,Proyecto):- cumpleRol(Persona,projecLeader),
								not((hayOtroLider(Persona,Proyecto))).
						
hayOtroLider(Persona,Proyecto):-trabajaEn(Proyecto,ListPersona),
								member(Persona,ListPersona),
								cumpleRol(Persona,projecLeader),
								trabajaEn(Proyecto,ListPersona2),
								member(Persona2,ListPersona2),
								cumpleRol(Persona2,projecLeader),
								Persona2 \= Persona.


								
													

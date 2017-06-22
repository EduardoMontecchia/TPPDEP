
/* Parte 1 */

/* Base de conocimiento */

programaEn(fernando,cobol).
programaEn(fernando,visualbasic).
programaEn(fernando,java).
programaEn(julieta,java).
programaEn(marcos,java).
programaEn(santiago,ecmascript).
programaEn(santiago,java).

rol(Persona,programador):- programaEn(Persona,_).
rol(fernando,analistaFuncional).
rol(andres,projectLeader).

/* ------- Consultas --------- */
 
/* programaEn(Lenguaje,fernando). */

/* programaEn(java,Quien). */

/* programaEn(assembler,Alguien).*/

/* rol(fernando,programador).*/

/* rol(fernando,Rol).*/

/* rol(Quien,programador).*/

/* rol(Alguien,projectLeader).*/

/* -------- Parte 2 ------------- */

proyecto(sumatra,java).
proyecto(sumatra,net).
proyecto(prometeus,cobol).

trabajaEn(prometeus,fernando).
trabajaEn(prometeus,santiago).
trabajaEn(sumatra,julieta).
trabajaEn(sumatra,marcos).
trabajaEn(sumatra,andres).

asignadoCorrectamente(Persona,Proyecto):- trabajaEn(Proyecto,Persona),proyecto(Proyecto,Lenguaje),programaEn(Persona,Lenguaje).
asignadoCorrectamente(Persona,Proyecto):- trabajaEn(Proyecto,Persona),cumpleRol(Persona,analistaFuncional).
asignadoCorrectamente(Persona,Proyecto):- trabajaEn(Proyecto,Persona),cumpleRol(Persona,projectLeader).

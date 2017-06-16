boliche(kika,10000).
boliche(theEnd,10000).
bar(miau).
fueA(alan,cataratas).
fueA(alan,kika).
fueA(alan,theEnd).
fueA(alberto,miau).
suma(X,Y,Z):- Z is X+Y. %Usar el is solamente en operaciones
capacidadNumerosa(Capacidad,Numero):-Capacidad>Numero.
feliz(juan).
feliz(alberto):-fueA(alberto,Lugar),boliche(Lugar,_).
feliz(gabriela):-boliche(_,Capacidad),capacidadNumerosa(Capacidad,1000).
feliz(juanCarlos):-fueA(juanCarlos,Lugar),
                   boliche(Lugar,Capacidad),
				   capacidadNumerosa(Capacidad,2000).
feliz(Persona):- fueA(Persona,Boliche1),
				 boliche(Boliche1,Capacidad),
                 fueA(Persona,Boliche2),
				 boliche(Boliche2,_),
				 Boliche1 \= Boliche2,
				 capacidadNumerosa(Capacidad,1000).
feliz(pedro):- not(fueA(pedro,_)).
realidadBolichera:-boliche(_,1000000). %regla sin ningun parametro

%Predicado unico

perro(rintintin,actor,aventurasenlaperrera).
perro(lassie,actor,lassielapelicula).
perro(scoobydoo,actor,scoobydoolapelicula).
perro(roco,mascota,lacasadetunovia).
famoso(Perro):-perro(Perro,actor,_).
%todaLaFama(Perro):-famoso(Perro), not(famoso(Otro),Perro\=Otro).
%todaLaFama(Perro):-famoso(Perro), not(hayUnFamosoDistintoA(Perro)).
%hayUnFamosoDistintoA(Perro):-famoso(Otro),Perro\=Otro.
%todaLaFama(Perro):-famoso(Perro),not(hayDosFamosos).
%hayDosFamosos:-famoso(Perro),famoso(Otro),Perro\=Otro.
comun(Perro):-perro(Perro,_,_),not(famoso(Perro)).
%mundoFamoso:-forall(perro(Perro,_,_), famoso(Perro)).
mundoFamoso:-not(comun(_)).
todaLaFama(Perro):-famoso(Perro),forall(famoso(X),X==Perro).
mundoCopado:-forall(boliche(_,Capacidad),Capacidad>1000).
%materia(paradigmas,sistemas).
%materia(informatica,industrial).
%esDeSistemas(Materia):-materia(Materia,sistemas).
%mundoSistemas:-forall(materia(Materia,_),esDeSistemas(Materia)).
jugador(riquelme,boca).
jugoEn(Equipo,Jugador):-jugador(Jugador,Equipo).
%equipoAcaparador(Equipo):-forall(jugador(Jugador,_),jugoEn(Equipo,Jugador)).
%equipoAcaparador(Equipo):-not((jugador(Jugador,_),not(jugoEn(Equipo,Jugador)))).
equipoAcaparador(Equipo):-esUnEquipo(Equipo),forall(jugador(Jugador,_),jugoEn(Equipo,Jugador)).
esUnEquipo(Equipo):-jugador(_,Equipo).
materia(pdep,2).
nota(lourdes,pdep,10).
nota(juan,pdep,7).
aproboanio(Persona,Anio):-esAlumno(Persona),
						  esUnAnio(Anio),
						  forall(materia(Materia,Anio),aprobo(Persona,Materia)).
aprobo(Persona,Materia):-nota(Persona,Materia,Nota),Nota>=6.
esUnAnio(Anio):-materia(_,Anio).
esAlumno(Persona):-nota(Persona,_,_).
regular(julieta).
regular(eduardo).
alumno(julieta,2005).
alumno(eduardo,2005).
alumno(cachito,2025).
asiste(eduardo).
asiste(julieta).
%cursoEjemplar:-forall(regular(Alumno),asiste(Alumno)).
%cursoEjemplar:-forall((alumno(Alumno,_),regular(Alumno)),asiste(Alumno)).
cursoEjemplar:-forall(alumno(Alumno,_),(regular(Alumno),asiste(Alumno))).
notas(ana,[1,2,3]).
notas(carlos,[]).
rindioMuchasVeces(Persona):-notas(Persona,Notas),sonMuchas(Notas).
sonNotas(Notas):-notas(_,Notas).
sonMuchas(Notas):-sonNotas(Notas),length(Notas,X),X>1.
%length([1,2,3],X). En X se devuelve la cantidad de elementos de la lista, en este caso 3.
%append([1,2],Y,[1,2,3]).=>[3]
%append(X,[2],[1,2]).=>[1]
%findall(X,alumno(X,2005),Alumnos). siendo Alumno una lista de alumnos, devuelve todos los X que cumplen
cursoNumeroso(Curso):-curso(Curso),
                      findall(X,alumno(X,Curso),Alumnos),
					  length(Alumnos,Cant),
					  Cant>30.
curso(Curso):-alumno(_,Curso).

:- use_module(library(clpfd)).

%Constraint Logic Programming Finite Domain
%#=

%Définir 3 prédicats
%Liste_longueur
%membre_liste
%indice_liste_element

%liste_longueur(L,N) est vrai si N est la longueur de la liste L
%fait : longueur de la liste vide est 0

liste_longueur([],0).

%règle : toute liste qui contient au moins un élément

liste_longueur([_X|L],N) :-  % <-
	N#>0,
	N#= N1+1,
	liste_longueur(L,N1).
%liste_longueur car liste en premier 	
%liste_longueur(L,3).

%prédicat prédéfini length

%Le programme dit ce qui est vrai
%donc pas de fait/règle pour dire que X n appartient pas à la liste
%vide


%fait : un élément appartient à une liste dont il est le premier élément

membre_liste(X,[X|_L]).

%règle : un élément appartient à une liste si il appartient à son reste.

membre_liste(X,[_|L]) :-
	membre_liste(X,L).

%prédicat prédéfini member

%Attention !!!
%l'accès au nième élément n'est PAS en temps constant

%Ecrire un prédicat indice_liste_element
%!!!!!!!!!!!on commence à compter de 1 !!!!!!!!!!!!!!!!

% ?-indice_liste_element(2,[a,b,c],Elt).
% Elt = b

%?-indice_liste_element(2,L,Elt).

%fait

indice_liste_element(1,[X|L],X).

%règle
indice_liste_element(N,[_Elt|L],Elt) :-
	N #>1, %pouréviter surtout les longueur négatives
	N1#=N-1,
	indice_liste_element(N1,L,Elt).

%nth0 nth1 sont prédéfinis 


%factorielle
%fait
entier_factorielle(0,1).

%règle
entier_factorielle(N,F):-
	N#>0,
	N1 #= N-1,
	F #= N*NF,
	entier_factorielle(N1,NF).
%fibonacci
entier_fib(0,0).
entier_fib(1,1).
entier_fib(N,F) :-
	N#>=2,     %En prolog : =< !!! 
	N1 #= N-1,
	N2 #= N-2,
	F #= F1+F2,
	entier_fib(N1,F1),
	entier_fib(N2,F2).
%On n'a pas pu calculer fibonacci de 30 !!

%between(0,infinite,N).
%between(0,infinite,N), entier_fib(N,R).
%between(0,infinite,N),time((entier_fib(N,R),write(N), write(' '), writeln(R),false)).
entier_fib_rapide(0,0).
entier_fib_rapide(1,1).
entier_fib_rapide(N,R):-
	N#>=2,
	entier_fib_acc(N,R,(0,1)).
entier_fib_acc(1,R,(_,R)).
entier_fib_acc(N,R,(X,Y)):-
	N#>=2,
	N1 #= N-1,
	NY #= X+Y,
	entier_fib_acc(N1,R,(Y,NY)).


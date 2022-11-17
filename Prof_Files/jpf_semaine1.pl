homme(albert).

homme(jean).

homme(paul).

homme(bertrand).

homme(louis).

homme(benoit).



femme(germaine).

femme(christiane).

femme(simone).

femme(marie).

femme(sophie).



pere_enfant(albert,jean).   % nommer les prédicats arg1_arg2_..._argn donc NE PAS avoir un prédicat pere(arg1,arg2)

pere_enfant(jean,paul).

pere_enfant(paul,bertrand).

pere_enfant(paul,sophie).

pere_enfant(jean,simone).

pere_enfant(louis,benoit).



mere_enfant(germaine,jean).

mere_enfant(christiane,simone).

mere_enfant(christiane,paul).

mere_enfant(simone,benoit).

mere_enfant(marie,bertrand).

mere_enfant(marie,sophie).


% listing

% make


parent_enfant(P,E) :-
    pere_enfant(P,E).

parent_enfant(P,E) :-
    mere_enfant(P,E).



fils_parent(F,P) :-      % doit être lu comme <-   implication vers la gauche
    parent_enfant(P,F),
    homme(F).


fille_parent(F,P) :-      % doit être lu comme <-   implication vers la gauche
    parent_enfant(P,F),
    femme(F).


grandPere_petitEnfant(GP,PE) :-
    pere_enfant(GP,P),
    parent_enfant(P,PE).


grandMere_petitEnfant(GP,PE) :-
    mere_enfant(GP,P),
    parent_enfant(P,PE).


frere_frereOuSoeur(F,X) :-
   fils_parent(F,P),
   parent_enfant(P,X),
   dif(F,X).

soeur_frereOuSoeur(F,X) :-
   fille_parent(F,P),
   parent_enfant(P,X),
   dif(F,X).



% graphe orienté (ici DAG) et pondéré/valué

origine_destination_cout(a,b,2).
origine_destination_cout(a,g,6).
origine_destination_cout(b,e,2).
origine_destination_cout(b,c,7).
origine_destination_cout(g,e,1).
origine_destination_cout(g,h,4).
origine_destination_cout(e,f,2).
origine_destination_cout(f,c,3).
origine_destination_cout(f,h,2).
origine_destination_cout(c,d,3).
origine_destination_cout(h,d,2).


% Définition d'un chemin de longueur au moins 1

% cas de base : chemin de longueur 1

origine_destination__chemin(S1,S2) :-
    origine_destination_cout(S1,S2,_).

% cas général : chemin de longueur au moins 2

% un chmein de longueur au moins 2 est constitué d'un arc et d'un chemin
% de longuer au moins 1

origine_destination__chemin(S1,S2) :-
   origine_destination_cout(S1,S,_),
   origine_destination__chemin(S,S2).






% Définition d'un chemin de longueur au moins 1 + chemin

% cas de base : chemin de longueur 1

origine_destination_chemin(S1,S2,(S1,S2)) :-
    origine_destination_cout(S1,S2,_).

% cas général : chemin de longueur au moins 2

% un chemin de longueur au moins 2 est constitué d'un arc et d'un
% chemin de longuer au moins 1

origine_destination_chemin(S1,S2,cons(S1,Chemin)) :-
   origine_destination_cout(S1,S,_),
   origine_destination_chemin(S,S2,Chemin).

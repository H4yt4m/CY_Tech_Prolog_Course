:- use_module(library(clpfd)).
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

parent_enfant(P, E):-pere_enfant(P, E).

parent_enfant(P, E):-mere_enfant(P, E).

fils_parent(F, P) :-
    parent_enfant(P,F),
    homme(F).

fille_parent(F,P):-
    parent_enfant(P,F),
    femme(F).

grandPere_petitEnfant(GP,PE):-
    pere_enfant(GP,P),
    parent_enfant(P,PE).

grandMere_petitEnfant(GM,PE):-
    mere_enfant(GM,M),
    parent_enfant(M,PE).

frere_frereOuSoeur(F,X):-
    fils_parent(F,P),
    parent_enfant(P,X),
    dif(F,X).

soeur_frereOuSoeur(F,X):-
    fille_parent(F,P),
    parent_enfant(P,X),
    dif(F,X).

%Graphe orienté et pondéré/valué.
%Ne pas appeler un prédicat père car on ne sait pas si gauche ou droit...

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

% Cas de base : Chemin de longueur 1

origine_destination__chemin(S1,S2) :-
    origine_destination_cout(S1,S2,_).

% Cas général : chemin de longueurau moins 2

% Un chemin de longueur au moins 2 est constitué d'un arc et 
% d'un chemin de longueur au moins 1

origine_destination__chemin(S1,S2) :-
    origine_destination_cout(S1,S,_),
    origine_destination__chemin(S,S2).

% Définition d'un chemin de longueur au moins 1 + chemin

% Cas de base : Chemin de longueur 1

origine_destination__chemin(S1,S2,(S1,S2)) :-
    origine_destination_cout(S1,S2,_).

% Cas général : chemin de longueurau moins 2

% Un chemin de longueur au moins 2 est constitué d'un arc et 
% d'un chemin de longueur au moins 1

origine_destination__chemin(S1,S2,cons(S1,Chemin)) :-
    origine_destination_cout(S1,S,_),
    origine_destination__chemin(S,S2,Chemin).

% Définition d'un chemin de longueur au moins 1 + chemin sous forme 
%de liste + coût

% cas de base : chemin de longueur 1 = 1 arc

origine_destination_chemin_cout(S1,S2,[S1,S2],Cout):-
    origine_destination_cout(S1,S2,Cout).

% Cas général : chemin de longueur au moins 2

% Un chemin de longueur au moins 2 est constitué d'un arc et d'un
% chemin de longueur au moins 1

origine_destination_chemin_cout(S1,S2,[S1|Chemin],Cout):-
    origine_destination_cout(S1,S,CoutArc),
    origine_destination_chemin_cout(S,S2,Chemin,CoutChemin),
    Cout #= CoutArc+CoutChemin.

%SI conjonction des buts du corps, Alors tête.

%Pour que la tête soit vraie, il suffit que la conjonction des buts 
%du corps soit vraie


%Le prédicat IS est interdit sauf mention explicite du contraire.
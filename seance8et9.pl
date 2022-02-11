:- use_module(library(clpfd)).

% Conjecture de syracuse/collatz/kakukani/3n+1

% Méthode 1
% syracuse_suivant(N,S):-
%     N mod 2 #= 0,
%     S #=N div 2.

%% Méthode 2
syracuse_suivant(N,S):-
    N#=2*S.

syracuse_suivant(N,S):-
    N#=2*_+1,
    S#=3*N+1.

% entier_listeSyracuse est vrai si L est la liste inversée des valeurs 
% des itérés de syracuse de l'entier n.

entier_listeSyracuse(N,L):-
    listeSyracuse_liste([N],L).
% Le premier élément vaut 1
listeSyracuse_liste([1|L],[1|L]).
% Le premier terme est strictement supérieur à 1
listeSyracuse_liste([N|L],LRes):-
    N #> 1,
    syracuse_suivant(N,S),
    listeSyracuse_liste([S,N|L],LRes).
% Dans terminal : entier_listeSyracuse(27,L),writeLn(L),length(L,N).


% Prédicats d'ordre supérieur
pair(N):-
    N #= 2*_.
% Dans terminal : include(pair,[5,3,4,6,4,2,3,8],L).
% include(Prédicat,+L,?L) (le plus mean L doit etre instancié et le ? pour ni entrée ni sortie (wtf))
% Dans terminal : partition(pair,[5,3,4,6,4,2,3,8],L,M).

entier_carre(N,Ncarre):-
    Ncarre #= N*N.

% Dans terminal : numlist(1,10,L),maplist(entier_carre,L,LL),sum_list(LL,N).
% Dans terminal : maplist(entier_carre,L,[25,36,49]).

% sum_list(L,N).

% liste_somme

% liste vide
liste_somme([],0).
% liste non vide
liste_somme([X|L],N):-
    N#=X+N1,
    liste_somme(L,N1).

% liste_produit

% liste vide
liste_produit([],1).
% liste non vide
liste_produit([X|L],N):-
    N#=X*N1,
    liste_somme(L,N1).

entier_entier_somme(N1,N2,S):-
    S#=N1+N2.

entier_entier_produit(N1,N2,S):-
    S#=N1*N2.

% Terminal : foldl(entier_entier_somme,[2,3,5,8],0,N).
% Terminal : foldl(entier_entier_produit,[2,3,5,8],1,N).

% Terminal : scanl(entier_entier_somme,[2,3,5,8],0,N).
% Terminal : scanl(entier_entier_produit,[2,3,5,8],1,N).

% Terminal : findall((L1,L2),append(L1,L2,[a,b,c]),L).
% Terminal : findall(L1,append(L1,L2,[a,b,c]),L).

entier_listeDiviseurs(N,L):-
    findall(
        Diviseur,
        (between(1,N,Diviseur),N #= _*Diviseur),
        L
    ).

premier(N):-
    entier_listeDiviseurs(N,[1|N]).

% Terminal : numlist(1,1_000,L),include(premier,L,LL).
% Terminal : numlist(1,1_000,L),include(premier,L,LL),length(LL,N).
% Terminal : entier_longueurSyracuse(377060271667498687,NN). (??)

%###################################################################

% tri par sélection
% tri par insertion
% tri fusion
% tri rapide
% tri par tas : on le le fait pas

% invariant habituel : | valeurs à leur place définitive | ?????? |
% On extrait le MINIMUM de la liste des valeurs non triés.

% Liste vide
liste_listeTriee__selection([],[]).
% Liste non vide
liste_listeTriee__selection([X|L],[Min,LL]):-
    liste_min_reste([X|L],Max, Reste),
    liste_listeTriee__selection(Reste,LL).
% Liste à un élement
liste_min_reste([Min],Min,[]).
% Liste à deux éléments
liste_min_reste([X1,X2|L],X1,[X2|L]):-
    X1 #< Min1,
    liste_min_reste([X2|L],Min1,_Reste).
    % POURQUOI PROB !!!

liste_min_reste([X1,X2|L],Min1,[X1|Reste]):-
    X1 #>= Min1,
    liste_min_reste([X2|L],Min1,Reste). 
    % POURQUOI PROB !!!

% Terminal : numlist(1,10,L),writeln(L),random_permutation(L,LL),writeln(LL).7
% Terminal : numlist(1,10,L),liste_listeTriee__selection(L,LLL). 
% Terminal : liste_listeTriee__selection([],LLL).
% Terminal : liste_listeTriee_selection([5],LLL).

% Liste vide
liste_listeTriee__insertion([],[]).
% Liste non vide
liste_listeTriee__insertion([X|L],LL) :-
    liste_listeTriee__insertion(L,LTriee),
    element_listeTriee_liste(X,LTriee,LL).

element_listeTriee_liste(X,[],[X]).
element_listeTriee_liste(X,[X1,L],[X,X1|L]) :-
    X #=< X1.
element_listeTriee_liste(X,[X1|L],[X1,LL]) :-
    X #> X1,
    element_listeTriee_liste(X,L,LL).

% Terminal : numlist(1,1_000,L),random_permutation(L,LL),liste_listeTriee__insertion(LL,LLL).

% A faire : Fusion buttom-up

liste_listeTriee__fusion([],[]).
% REMARQUES GÉNÉRALES
% Si on a entier : savoir ce qui se passe s'il est nul
% Si on a liste (ou chaine de caractère): savoir ce qui se passe s'elle est vide

liste_listeTriee__fusion([X],[X]).

liste_listeTriee__fusion([X|L],LTriee) :-
    liste_indicesPairs_indicesImpairs([X1,X2|L],LP,LI),
    liste_listeTriee__fusion(LP,LPTriee),
    liste_listeTriee__fusion(LI,LITriee),
    liste_liste_fusion(LPTriee,LITriee,LTriee).

liste_indicesPairs_indicesImpairs([],[],[]).
liste_indicesPairs_indicesImpairs([X],[X],[]).
liste_indicesPairs_indicesImpairs([X1,X2|L],[X1|L1],[X2|L2]):-
    liste_indicesPairs_indicesImpairs(L,L1,L2).

% Terminal : liste_indicesPairs_indicesImpairs([8,5,21,34,13,5],L1,L2).
% Terminal : 

liste_liste_fusion([],L2,L2).
liste_liste_fusion(L1,[],L1).

liste_liste_fusion([X1|L1],[X2|L2],[X1|LL]):-
    X1#=<X2,
    liste_liste_fusion(L1,[X2|L2],LL).

liste_liste_fusion([X1|L1],[X2|L2],[X2|LL]):-
    X1#>X2,
    liste_liste_fusion([X1|L1],L2,LL).

% Terminal : numlist(1,1_000,L),random_permutation(L,LL),liste_listeTriee__fusion(LL,LLL).
% (doesn't work...)
% Terminal : numlist(1,100000,L),random_permutation(L,LL),time(liste_listeTriee__fusion(LL,LLL)).
% (doesn't work...)

% Tri rapide : Quick sort
% on sépare la liste en fonction des VALEURS, donc l'arbre d'appels
% N'est PAS toujours équilibré

liste_liste_quicksort([],[]).
liste_liste_quicksort([X],[X]).
liste_liste_quicksort([Pivot,X2|L],LTriee) :-
    liste_pivot_petits_grands([X2|L],Pivot,Petits,Grands),
    liste_liste_quicksort(Petits,PetitsTries),
    liste_liste_quicksort(Grands,GrandsTries),
    append(PetitsTries,[Pivot|GrandsTries],LTriee).

liste_pivot_petits_grands([],_Pivot,[],[]).
liste_pivot_petits_grands([X|L],Pivot,[X|L1],L2):-
    X #=< Pivot,
    liste_pivot_petits_grands(L,Pivot,L1,L2).

liste_pivot_petits_grands([X|L],Pivot,L1,[X|L2]):-
    X #=< Pivot,
    liste_pivot_petits_grands(L,Pivot,L1,L2).

% Terminal : numlist(1,1000,L),random_permutation(L,LL),time(liste_liste_quicksort(LL,LLL)).
% (doesn't work...)


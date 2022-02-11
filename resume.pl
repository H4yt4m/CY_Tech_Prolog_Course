
:- use_module(library(clpfd)).
% Liste - Matrice - Chemin - factorielle - pgcd - premier - fib - les tris - 

% Fcts utiles :
between(0,infinite,N).
length(L,10). 
append(LCarre,LCube,L). %les deux liste dans
                        %la nouvelle liste
all_distinct(L).
dif(A,B).
label(L). %???
include(Goal, List,ListDesTrue).
exclude(Goal, List,ListDesFalse).
partition(Goal, List, ListDesTrue, ListDesFalse).
maplist(Goal, List1, List2,...). %True si tous elements 
                                 % verifient goal
findall(Template, Goal, List). % Voir premier
                              
% Liste dernier element :
dernier_liste(X,[X]).

dernier_liste(Dernier,[_X1,X2|L]) :-
    dernier_liste(Dernier,[X2|L]).

% Liste chiffres nombre :
entier_listeChiffres(N,[N]) :-
    between(0,9,N).

entier_listeChiffres(N,[Unite|ListeDizaines]) :-
    N #>= 10,
    Unite #= N mod 10,
    Dizaines #= N div 10,
    entier_listeChiffres(Dizaines,ListeDizaines).

% Liste appartenance :
membre_liste(X,[X|_L]).

membre_liste(X,[_Y|L]) :-  
    membre_liste(X,L).

% Liste element de l'indice donne :
indice_liste_element(1,[Elt|_L],Elt).

indice_liste_element(N,[_Elt|L],Elt) :-
    N #> 1,
    N1 #= N-1,
    indice_liste_element(N1,L,Elt).

% Produit élements liste
liste_produit([],1).

liste_produit([X|L],N) :-
    liste_produit(L,N1),
    N #= X*N1.

% Maximum liste :
liste_max([X],Res) :-
    Res #= X.

liste_max([X1,X2|L],Res) :-
    liste_max([X2|L],Res1),
    Val #= X1,
    entier_entier_max(Val,Res1,Res).

entier_entier_max(N1,N2,N1) :-
    N1 #>= N2.

entier_entier_max(N1,N2,N2) :-
    N1 #< N2.

% Produit matrices :
matrice_matrice_produit([[A11,A12],[A21,A22]],
                        [[B11,B12],[B21,B22]],
                        [[M11,M12],[M21,M22]]) :-
    M11 #= A11*B11+A12*B21,
    M12 #= A11*B12+A12*B22,
    M21 #= A21*B11+A22*B21,
    M22 #= A21*B12+A22*B22.

matrice_vecteur_produit([[A11,A12],[A21,A22]],
                        [B11,B21],
                        [M11,M21]) :-
    M11 #= A11*B11+A12*B21,
    M21 #= A21*B11+A22*B21.

% un chemin de longueur au moins 2 est constitu� d'un arc et d'un
% chemin de longuer au moins 1
origine_destination_cout(h,d,2).

origine_destination_chemin(S1,S2,cons(S1,Chemin)) :-
    origine_destination_cout(S1,S,_),
    origine_destination_chemin(S,S2,Chemin).

% Factorielle :
entier_factorielle(0,1).

entier_factorielle(N,F) :-
    N #> 0,
    N1 #= N-1,
    F #= N*NF,
    entier_factorielle(N1,NF).

% PGCD :
entier_entier_pgcd(A,0,A) :-
    A #>= 0.

entier_entier_pgcd(A,B,Pgcd) :-
    B #>= 1,
    R #= A mod B,
    entier_entier_pgcd(B,R,Pgcd).

% Premier :
compose(N) :-
    N #>= 4,
    1 #< N1, N1 #< N,
    N #= N1*_N2.

premier(N) :-
    N #>= 2,
    \+ compose(N).
% OU :
entier_listeDiviseurs(N,L) :-
    findall(
            Diviseur,
            (between(1,N,Diviseur), N #= _*Diviseur),
            L
           ).

premier(N) :-
    entier_listeDiviseurs(N,[1,N]).

% Fibonacci
entier_fib(0,0).

entier_fib(1,1).

entier_fib(N,F) :-
    N #>= 2,         
    N1 #= N-1,
    N2 #= N-2,
    F #= F1+F2,
    entier_fib(N1,F1),
    entier_fib(N2,F2).

% Tri selection :
liste_listeTriee__selection([],[]).

liste_listeTriee__selection([X|L],[Min|LL]) :-
    liste_min_reste([X|L],Min,Reste),
    liste_listeTriee__selection(Reste,LL).

liste_min_reste([Min],Min,[]).

liste_min_reste([X1,X2|L],X1,[X2|L]) :-
    X1 #< Min1,
    liste_min_reste([X2|L],Min1,_Reste).

liste_min_reste([X1,X2|L],Min1,[X1|Reste]) :-
    X1 #>= Min1,
    liste_min_reste([X2|L],Min1,Reste).

% Tri insertion :
liste_listeTriee__insertion([],[]).

liste_listeTriee__insertion([X|L],LL) :-
    liste_listeTriee__insertion(L,LTriee),
    element_listeTriee_liste(X,LTriee,LL).

element_listeTriee_liste(X,[],[X]).

element_listeTriee_liste(X,[X1|L],[X,X1|L]) :-
    X #=< X1.

element_listeTriee_liste(X,[X1|L],[X1|LL]) :-
    X #> X1,
    element_listeTriee_liste(X,L,LL).

% Tri fusion :
liste_listeTriee__fusion([],[]).

liste_listeTriee__fusion([X],[X]).

liste_listeTriee__fusion([X1,X2|L],LTriee) :-
    liste_indicesPairs_indicesImpairs([X1,X2|L],LP,LI),
    liste_listeTriee__fusion(LP,LPTriee),
    liste_listeTriee__fusion(LI,LITriee),
    liste_liste_fusion(LPTriee,LITriee,LTriee).

liste_indicesPairs_indicesImpairs([],[],[]).

liste_indicesPairs_indicesImpairs([X],[X],[]).

liste_indicesPairs_indicesImpairs([X1,X2|L],[X1|L1],[X2|L2]) :-
    liste_indicesPairs_indicesImpairs(L,L1,L2).

liste_liste_fusion([],L2,L2).

liste_liste_fusion(L1,[],L1).

liste_liste_fusion([X1|L1],[X2|L2],[X1|LL]) :-
    X1 #=< X2,
    liste_liste_fusion(L1,[X2|L2],LL).

liste_liste_fusion([X1|L1],[X2|L2],[X2|LL]) :-
    X1 #> X2,
    liste_liste_fusion([X1|L1],L2,LL).

% Tri rapide : quicksort :
liste_liste__quicksort([],[]).

liste_liste__quicksort([X],[X]).

liste_liste__quicksort([Pivot,X2|L],LTriee) :-
    liste_pivot_petits_grands([X2|L],Pivot,Petits,Grands),
    liste_liste__quicksort(Petits,PetitsTries),
    liste_liste__quicksort(Grands,GrandsTries),
    append(PetitsTries,[Pivot|GrandsTries],LTriee).

liste_pivot_petits_grands([],_Pivot,[],[]).

liste_pivot_petits_grands([X|L],Pivot,[X|L1],L2) :-
    X #=< Pivot,
    liste_pivot_petits_grands(L,Pivot,L1,L2).

liste_pivot_petits_grands([X|L],Pivot,L1,[X|L2]) :-
    X #> Pivot,
    liste_pivot_petits_grands(L,Pivot,L1,L2).
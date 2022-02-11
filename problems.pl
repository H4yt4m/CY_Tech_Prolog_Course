:- use_module(library(clpfd)).
% p01 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dernier_liste(X,[X]).
dernier_liste(Dernier,[_X1,X2|L]):-
    dernier_liste(Dernier,[X2|L]).

% p02 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avantDernier_liste(X1,[X1,X2]).
avantDernier_liste(AvantDernier,[_X1,X2,X3|L]):-
    avantDernier_liste(AvantDernier,[X2,X3|L]).

% p03 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% indice_list_element avec les arguments en ordre inverse

% p04 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% liste_longueur

% p05 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
liste_inverse([],[]).
liste_inverse([X|L],LL):-
    liste_inverse(L,LInverse),
    liste_liste_concatenation(LInverse,[X],LL).

%liste_liste_concatenation(L1,L2,L3) est vrai si L3 est la 
%concatenation de L1 et L2

%A priori, on a deux cas à considérer pour L1 (vide ou non), 
%et deux pour L2 (vide ou non)

% L1 / L2  |  vide  |  non vide
%-------------------------------
% vide     |   []   | L2
%-------------------------------
% non vide |   L1   | L1 + L2

% Version longue

% liste_liste_concatenation([],[],[]).
% liste_liste_concatenation([],[X|L2],[X|L2]).
% liste_liste_concatenation([X|L1],[],[X,L1]).
% liste_liste_concatenation([X|L1],[Y|L2],[X|LL]):-
%     liste_liste_concatenation(L1,[Y|L2],LL).

% Version courte 

liste_liste_concatenation([],L2,L2).
liste_liste_concatenation([X|L1],L2,[X|LL]):-
    liste_liste_concatenation(L1,L2,LL).

% p06 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

palindrome(L):-
    liste_inverse(L,L).
% Spécification swi : une chaine avec des backquotes est une liste
% de caractères.

% p31 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1 n'est ni premier ni composé 

% !! On va utiliser la négation notée \+ !!
% Ici, on dira qu'un nombre est premier s'il est supérieur ou égal 
% à 2 et qu'il n'est pas composé.

% compose(N) est vrai si N admet un diviseur qui est ni un ni lui 
% même

compose(N):-
    N#>=4,
    1 #< N1, N1 #< N,
    N #= N1*_.

% prédicat numlist(Inf,Sup,L) est vrai si L contient les entiers
% de Inf à Sup (les deux inclus).

% prédicat include(Prédicat,L,LL) est vrai si LL contient les 
% éléments de L qui vérifient le Prédicat.
premier(N):-
    N#>=2,
    \+ compose(N).

% p32 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

entier_entier_pgcd(A,0,A):-
    A#>=0.
entier_entier_pgcd(A,B,Pgcd):-
    R #= A mod B,
    entier_entier_pgcd(B,R,Pgcd).

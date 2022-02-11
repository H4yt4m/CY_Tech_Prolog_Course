% clpfd
%
% Constraint Logic Programming Finite Domain
:- use_module(library(clpfd)).

% Un fermier a des poules et des vaches
% Il a au total 30 animaux
% Les animaux ont au total 74 jambes

% Terminal : Poules + Vaches #= 30, 2*Poules + 4*Vaches #= 74, Poules in 0..sup.
% Terminal : Poules + Vaches #= 30, 2*Poules + 4*Vaches #= 74, Poules in 0..sup, Vaches in 0..sup. (donne la solution)

% Coloration de graphe
carte(Regions,NbCouleurs) :-
    Regions = [A,B,C,D,E,F],
    Regions ins 1..NbCouleurs, %si ins 0..0 donc une couleure, 0..1 2 couleurs etc
    A#\=B, A#\=C, A#\=D, A#\=F,
    B#\=C, B#\=D,
    C#\=D, C#\=E,
    D#\=E, D#\=F,
    E#\=F.

% Terminal : carte(Regions), label(Regions).
% Terminal : carte(Regions,4),label(Regions). MARCHE CAR N'IMPORTE GRAPHE PLANAIRE PEUT ETRE COLORIÉ AVEC 4 COULEURS
% Terminal : carte(Regions,4),Regions = [1,2|_],label(Regions).

carte2(Regions,NbCouleurs) :-
    Regions = [A,B,C,D,E,F],
    Regions ins 1..NbCouleurs, 
    maplist(#\=(A),[B,C,D,F]),
    maplist(#\=(B),[C,D]),
    maplist(#\=(C),[D,E]),
    maplist(#\=(D),[E,F]),
    E#\=F.
% A TERMINER https://ucergyfr.sharepoint.com/sites/ING1_GI_prolog/Documents%20partages/Forms/AllItems.aspx?id=%2Fsites%2FING1%5FGI%5Fprolog%2FDocuments%20partages%2FGeneral%2FRecordings%2Fprolog%20ING1GI%2D20210412%5F145308%2DEnregistrement%20de%20la%20r%C3%A9union%2Emp4&parent=%2Fsites%2FING1%5FGI%5Fprolog%2FDocuments%20partages%2FGeneral%2FRecordings

takeout(X,[X|R],R).  
takeout(X,[F |R],[F|S]) :- takeout(X,R,S).

perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).  
perm([],[]).


numbers_atoms([],[]).

numbers_atoms([X|Y],[C|K]) :-
    atom_number(C, X),
    numbers_atoms(Y,K).

digits_number(Digits, Number) :-
    numbers_atoms(Digits, Atoms),
    number_codes(Number, Atoms).
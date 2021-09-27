:- use_module(library(clpfd)).
is(X) :-
	crypto_is_prime(X, []).


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


	
make_list(X, S, T, TS) :-
	X =:= S,
	append(T, [S], TS), !.
make_list(X, S, T, TS) :-
	X1 is X + 1,
	append(T, [X], T1),
	make_list(X1, S, T1, TS).


kilo([],[]).
kilo([N | NS], [D | DS]) :-
	digits_number(N, D),
	kilo(NS, DS).


big([], _).
big([L | _], X) :-
	is(L),
	X = L, !.
big([_ | LS], X) :-
	big(LS, X).


find(X, Y) :-
	make_list(1, X, [], T),
	findall(M, perm(T, M), K),
	sort(0, @>, K, KM),
	kilo(KM, KY),
	big(KY, Y).
find(X, _) :-
	X =:= 1, !.

find(X, Y) :-
	X1 is X - 1,
	find(X1, Y).
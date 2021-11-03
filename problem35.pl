:- use_module(library(crypto)).
:- use_module(library(clpfd)).

check_if_prime(A):-
	crypto_is_prime(A, [2]).

list_prime(L):-
	number_chars(X, L),
	check_if_prime(X).

rotatelist([H|T], R) :- append(T, [H], R).


one_rotation(T, 1, T).
one_rotation(L, X, RL):-
	X > 0,
	rotatelist(L, T),
	X1 is X - 1,
	one_rotation(T, X1, RL).

all_rotations(L, RL):-
	length(L, Y),
	between(1, Y, X),
	one_rotation(L, X, RL).

circular_prime(X):-
	check_if_prime(X),
	number_chars(X, Xs),
	forall(all_rotations(Xs, L), list_prime(L)).

charles(X):-
	findall(Y, (between(1, 1_000_000, Y), circular_prime(Y)), Ys),
	length(Ys, X).
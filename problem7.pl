:- use_module(library(crypto)).

check_if_prime(A):-
	crypto_is_prime(A, [2]).

next_prime(A, B):-
	B is A + 1,
	crypto_is_prime(B, [2]).

next_prime(A, B):-
	A0 is A + 1,
	next_prime(A0, B).

find_X_prime(X, Y, X, P) :-
	next_prime(P, Y).
find_X_prime(X, Y, N, P):-
	N0 is N + 1,
	next_prime(P, P0),
	find_X_prime(X, Y, N0, P0).
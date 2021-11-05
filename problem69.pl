:- use_module(library(crypto)).

check_if_prime(A):-
	crypto_is_prime(A, [2]).

factorial_prime(0,1).
factorial_prime(N,M):-
	N>0,
	check_if_prime(N),
	N1 is N-1,
	factorial_prime(N1, M1),
	M is N*M1.
factorial_prime(N, M):-
	N>0,
	N1 is N-1,
	factorial_prime(N1, M), !.

charles(V):-
	findall(Y, (between(1, 50, X),factorial_prime(X,Y),Y < 1_000_000), Ys),
	max_list(Ys, V).
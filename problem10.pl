:- use_module(library(crypto)).

check_if_prime(A):-
	crypto_is_prime(A, [2]).

next_prime(A, B):-
	B is A + 1,
	crypto_is_prime(B, [2]).

next_prime(A, B):-
	A0 is A + 1,
	next_prime(A0, B),
	!.

sum_of_primes_to(B, C_P, S_N, S):-
	next_prime(C_P, N_P),
	N_P < B,
	S1_N is S_N + N_P,
	!,
	sum_of_primes_to(B, N_P, S1_N, S).

sum_of_primes_to(_, _, S, S).
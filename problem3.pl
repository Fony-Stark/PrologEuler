:- use_module(library(crypto)).

check_if_prime(A):-
	crypto_is_prime(A, [2]).

highest_prime_factor(A, B):-
	gen_primes(A, 2, T),
	reverse(T, [B|_]), !.

is_prime_factor(A, B):-
	check_if_prime(B),
	0 is mod(A, B).

gen_primes(1, _, []):- !.

gen_primes(A, N, [N | T]) :-
	is_prime_factor(A, N),
	A0 is A / N,
	gen_primes(A0, N, T).

gen_primes(A, N, T) :-
	\+ is_prime_factor(A, N),
	next_prime(N, N0),
	gen_primes(A, N0, T).

next_prime(A, B):-
	B is A + 1,
	crypto_is_prime(B, [2]).

next_prime(A, B):-
	A0 is A + 1,
	next_prime(A0, B).
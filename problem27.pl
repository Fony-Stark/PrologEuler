:- use_module(library(crypto)).

is_prime(X) :-
	crypto_is_prime(X, []).

count(A, B, I, N) :-
	pow(I, 2, I_square),
	Y is I_square + (A * I) + B,
	is_prime(Y),
	I2 is I + 1,
	count(A, B, I2, N).

count(_, _, I, N) :-
	N = I, !.

consecutive_primes(A, B, N) :-
	count(A, B, 0, N).
	

charles(Product_found, Max_primes_found) :-
	Max_primes = counter(0),

	between(-1000, 1000, A_val), 
	between(-1000, 1000, B_val),
	consecutive_primes(A_val, B_val, N_primes),

	arg(1, Max_primes, Current_max),

	N_primes > Current_max,

	Local_max is A_val * B_val,

	nb_setarg(1, Max_primes, N_primes),

	Product_found = Local_max,
	Max_primes_found = N_primes.
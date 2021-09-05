emitco(D, _, D).
emitco(D, C, C) :-
    dif(D, C).

divisor(N, R) :-
    UB is floor(sqrt(N)),
    between(1, UB, D),
    0 is N mod D,
    C is N / D,
    emitco(D, C, R).

num_divisors(N, L) :-
	setof(D, divisor(N, D), Ds), 
	length(Ds, L).

give_answer(N, K, _, N) :-
	num_divisors(N, K),
	K >= 500.

give_answer(N, K, I, M) :-
	N1 is N + I,
	I1 is I + 1,
	give_answer(N1, K, I1, M), !.
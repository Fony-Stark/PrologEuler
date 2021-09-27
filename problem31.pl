all_comb(X1, X2, X3, X4, X5, X6, X7) :-
	between(0, 2, X1),
	T is (200 - 100 * X1) // 50,
	between(0, T, X2),
	T1 is (200 - 100 * X1 - X2 * 50) // 20,
	between(0, T1, X3),
	T2 is (200 - 100 * X1 - X2 * 50 - X3 * 20) // 10,
	between(0, T2, X7),
	T3 is (200 - 100 * X1 - X2 * 50 - X3 * 20 - X7 * 10) // 5,
	between(0, T3, X4),
	T4 is (200 - 100 * X1 - X2 * 50 - X3 * 20 - X4 * 5 - X7 * 10) // 2,
	between(0, T4, X5),
	X6 is 200 - 100 * X1 - X2 * 50 - X3 * 20 - X4 * 5 - X5 * 2 - X7 * 10,
	200 is X1 * 100 + X2 * 50 + X3 * 20 + X4 * 5 + X5 * 2 + X6 * 1 + X7 * 10.

charles(X) :-
	Counter = counter(0),
	all_comb(X1, _, _, _, _, _, _),

	arg(1, Counter, N1),
	N is N1 + 1,

	nb_setarg(1, Counter, N),
	X1 =:= 2,
	X is N + 1.
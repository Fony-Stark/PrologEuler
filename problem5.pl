answer_a(X):-
	A0 is lcm(11, 12),
	A1 is lcm(A0, 13),
	A2 is lcm(A1, 14),
	A3 is lcm(A2, 15),
	A4 is lcm(A3, 16),
	A5 is lcm(A4, 17),
	A6 is lcm(A5, 18),
	A7 is lcm(A6, 19),
	X is lcm(A7, 20).

answer_b(X, A) :-
	A0 is A - 1,
	answer_b_help(X, A, A0).

answer_b_help(X, 1, X):- !.
answer_b_help(X, A, C):-
	C0 is lcm(A, C),
	A0 is A - 1,
	answer_b_help(X, A0, C0).
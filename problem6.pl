sum(0, X, X).
sum(A, B, X):-
	A0 is A - 1,
	B0 is B + A,
	sum(A0, B0, X).

squrValue(A, B):-
	sum(A, 0, X),
	B is X * X.

sumA(0, X, X).
sumA(A, B, X):-
	A0 is A - 1,
	B0 is B + A * A,
	sumA(A0, B0, X).

sumValue(A, B):-
	sumA(A, 0, B).

answer(X, Y):-
	squrValue(X, S0),
	sumValue(X, S1),
	Y is S0 - S1, !.
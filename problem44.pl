pentagol(N, Y) :-
	N > 0,
	Y is (N * (3 * N - 1)) // 2.

is_pentagol(X) :-
	A = 3,
	B = -1,
	C is - X * 2,

	Y1 is sqrt(B*B - 4 * A *C),
	Y2 is 2 * A,
	Y is round((-B + Y1)/Y2),

	pentagol(Y, X).

charles(Answer) :-
	between(1, 10000, X),
	between(1, 10000, Y),
	X > Y,

	pentagol(X, X1),
	pentagol(Y, Y1),

	Answer is X1 - Y1,
	is_pentagol(Answer),

	B is X1 + Y1,

	is_pentagol(B),
	!.
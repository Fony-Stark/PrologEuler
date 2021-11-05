same_list([], []):- !.
same_list([H1 | T1], [H2 | T2]):-
	H1 = H2,
	same_list(T1, T2).

charles(X):-
	between(1000_000_000, 1999_999_999, X),
	V is X * X,
	number_chars(V, Vlist),
	length(Vlist, 19),
	V = [H | T],
	H = '1',
	same_list(T, [A1, '2', A2, '3', A3, '4', A4, '5', A5, '6', A6, '7', A7, '8', A8, '9', A9, '0']).
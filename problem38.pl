check_list([], _).
check_list([H | C], L):-
	member(H, L),
	check_list(C, L).

full_list(L):-
	check_list(['9','8','7','6','5','4','3','2','1'], L).

pandigital(_, _, L, V):-
	length(L, 9),
	full_list(L),
	number_chars(V, L),
	!.
pandigital(X, I, L, Ly):-
	length(L, Y),
	Y < 9,
	X1 is X * I,
	I1 is I + 1,
	number_chars(X1, Xs),
	append(L, Xs, L1),
	pandigital(X, I1, L1, Ly).

charles(V):-
	findall(Y,(
		between(1, 100_000, X),
		pandigital(X, 1, [], Y)),
		Ys),
	max_list(Ys, V).
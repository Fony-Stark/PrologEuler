sum_chars([], 0).
sum_chars([H | T], N):-
	sum_chars(T, N1),
	number_chars(V, [H]),
	N is N1 + V * V.

next_chain(V, N):-
	number_chars(V, L),
	sum_chars(L, N).

full_chain(_, N):-
	N =:= 89, !.
full_chain(Count, N):-
	Count < 100,
	\+ N =:= 1,
	C is Count + 1,
	next_chain(N, V),
	full_chain(C, V).

charles(X):-
	findall(_, (between(1, 10_000_000, Y), full_chain(1, Y)), Ys),
	length(Ys, X).
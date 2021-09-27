append_set(Item, Set, Newset) :-
	(member(Item, Set) ->
		Newset = Set
	;
		Newset = [Item | Set]).

find_all_powers(X) :-
	between(2, 100, A),
	between(2, 100, B),
	pow(A, B, X).

charles(Length) :-
	findall(X, find_all_powers(X), Y),
	add(Y, [], Z),
	length(Z, Length).

add([X | Z], F, Hey) :-
	append_set(X, F, F1),
	add(Z, F1, Hey).

add([], Hey, Hey).
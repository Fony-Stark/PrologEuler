mult(2, Akk, Akk):- !.

mult(S, Akk1, Akk):-
	(0 is mod(S, 3) ->
		Akk2 is Akk1 + S
	;
		(0 is mod(S, 5) ->
			Akk2 is Akk1 + S
		;
			Akk2 is Akk1
		)
	),
	S1 is S - 1,
	mult(S1, Akk2, Akk).
use_module(library(list)).
use_module(library(clpfd)).

palindrome(X):-
	reverse(X, X).

is_num_palin(X):-
	number_chars(X, Y),
	palindrome(Y).

solution_a(N, S):-
	is_num_palin(N),
	N #= X * Y,
	integer(X),
	integer(Y),
	X > 99,
	X < 1000,
	Y > 99,
	Y < 1000,
	S is N.

solution_a(N, S):-
	N0 is N - 1,
	solution_a(N0, S).
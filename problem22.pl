:- include('problem22_names_fixed.txt').

hey(Answer) :-
	Counter = counter(0),
	name(_, Y),
	arg(1, Counter, N0),
	N is N0 + Y,
	nb_setarg(1, Counter, N),
	Y =:= 0,
	Answer = N.
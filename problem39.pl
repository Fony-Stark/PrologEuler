:- use_module(library(clpfd)).

perimeter(A, B, C, P):-
	P #= A + B + C.

right_triagle(A, B, C):-
	Cpow2 #= A*A + B*B,
	Cpow2 #= C*C,
	B #>= A,
	C #> B.

charles(X, Longest):-
	Max = counter(0),
	between(1, 1000, X), 

	A #> 0, B #> 0, C #> X // 3,
	C #< X // 2,
	
	perimeter(A, B, C, X), 
	right_triagle(A, B, C),  

	findall(C, label([C]), Xs),

	length(Xs, Longest),
	arg(1, Max, Saved),
	
	Longest #> Saved,
	nb_setarg(1, Max, Longest).
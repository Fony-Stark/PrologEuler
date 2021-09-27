:- use_module(library(crypto)).

remove_last_digit(X, Y) :-
	Y is X // 10.

remove_first_digit(X, Y) :-
	between(1, 10, Z),
	pow(10, Z,High),
	High > X, 
	Rest is X // (High / 10),
	Y is X - (High / 10) * Rest,
	!.

is_prime(X) :-
	crypto_is_prime(X, []).

front(X) :-
	is_prime(X),
	remove_first_digit(X, Y),
	Y > 0,
	is_prime(Y),
	!,
	front(Y).

front(X) :-
	is_prime(X),
	remove_first_digit(X, Y),
	Y =:= 0.

back(X) :-
	X >= 10,
	is_prime(X),
	remove_last_digit(X, Y),
	!,
	back(Y).

back(X) :-
	is_prime(X).

is_truncatable(X) :-
	X > 10,
	is_prime(X),
	back(X),
	front(X).

charles(Answer) :-
	Counter = counter(0),
	Sum = counter(0),
	
	between(1, 10000000, X),
	is_truncatable(X),

	arg(1, Counter, Current_count),
	arg(1, Sum, Current_sum),
	
	Inc_count is Current_count + 1,
	Inc_sum is Current_sum + X,
	
	nb_setarg(1, Counter, Inc_count),
	nb_setarg(1, Sum, Inc_sum),

	Inc_count =:= 11,
	Answer = Inc_sum, 
	!.
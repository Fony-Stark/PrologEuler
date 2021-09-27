number_to_digits(0, _).
number_to_digits(Number, Digits) :-
	Number > 0,
    RemainingNumber is div(Number, 10),
    LastDigit is mod(Number, 10),
    append(RemainingDigits, [LastDigit], Digits), 
    number_to_digits(RemainingNumber, RemainingDigits), !.


is_fifth_power(X) :-
	number_to_digits(X, Y),
	sum_fith(Y, 0, Z),
	X is Z.

sum_fith([X | Z], Temp, Y) :-
	pow(X, 5, T),
	Temp1 is Temp + T,
	sum_fith(Z, Temp1, Y).

sum_fith([], X, X).

charles(Y) :-
	Counter = counter(0),
	between(10, 10000000, X),
	is_fifth_power(X),
	arg(1, Counter, N0),
	N is N0 + X,
	nb_setarg(1, Counter, N),
	X =:= 194979,
	Y = N.
number_to_digits(0, _).
number_to_digits(Number, Digits) :-
	Number > 0,
    RemainingNumber is div(Number, 10),
    LastDigit is mod(Number, 10),
    append(RemainingDigits, [LastDigit], Digits), 
    number_to_digits(RemainingNumber, RemainingDigits), !.

factorial(1, X, Y) :-
	Y = X,
	!.
factorial(Number, Current, Result) :-
	X is Current * Number,
	Y is Number - 1,
	factorial(Y, X, Result).

add_list([], X, X).
add_list([Digit | Tail], Current, Sum) :-
	X is Current + Digit,
	add_list(Tail, X, Sum).

solution(Number, Z) :-
	factorial(Number, 1, X),
	number_to_digits(X, Y),
	add_list(Y, 0, Z).
numbers_atoms([],[]).

numbers_atoms([X|Y],[C|K]) :-
    atom_number(C, X),
    numbers_atoms(Y,K).

digits_number(Digits, Number) :-
    numbers_atoms(Digits, Atoms),
    number_codes(Number, Atoms).

number_to_digits(0, _).
number_to_digits(Number, Digits) :-
	Number > 0,
    RemainingNumber is div(Number, 10),
    LastDigit is mod(Number, 10),
    append(RemainingDigits, [LastDigit], Digits), 
    number_to_digits(RemainingNumber, RemainingDigits), !.

not_palindrome(X) :-
	\+ is_palindrome(X).

is_palindrome(X) :-
	number_to_digits(X, Y),
	reverse(Y, Y).

get_reverse(X, Y) :-
	number_to_digits(X, A),
	reverse(A, B),
	digits_number(B, Y).

charles(Answer) :-
	Counter = counter(0),
	between(1, 10000, X),
	is_lychrel(X),

	arg(1, Counter, Temp),
	F is Temp + 1,

	nb_setarg(1, Counter, F),

	write(F), nl,
	X =:= 10000,
	F = Answer.

is_lychrel(Number) :-
	Check = counter(0),
	fix(Number, Check).

fix(Number, Gert) :-
	arg(1, Gert, Current_val),
	get_reverse(Number, XNumber),

	Sum = Number + XNumber,
	not_palindrome(Sum),

	C_val is Current_val + 1,
	nb_setarg(1, Gert, C_val),

	C_val =:= 50, !.
fix(Number, T) :-
	get_reverse(Number, XNumber),

	Sum = Number + XNumber,
	not_palindrome(Sum),
	fix(Sum, T).
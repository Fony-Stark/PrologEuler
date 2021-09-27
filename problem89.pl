:- [problem89_roman].

charles(Saved) :-
	Counter = counter(0),
	forall(roman_number(X), find_and_add(X, Counter)),
	arg(1, Counter, Saved).

find_and_add(Roman_number, Counter) :-
	arg(1, Counter, Current_sum),
	
	save(Roman_number, Saved_did),

	Inc_sum is Current_sum + Saved_did,

	nb_setarg(1, Counter, Inc_sum).

save(Roman, Saved) :-
	roman_to_decimal(Roman, Decimal, LengthRoman),
	optimal(Decimal, RomanOpt, LengthOpt),
	Saved is LengthRoman - LengthOpt,
	check(Roman, RomanOpt, Decimal), !.

check(_, Roman, Decimal) :-
	roman_to_decimal(Roman, Decimal, _).

check(ARoman, Roman, Decimal) :-
	roman_to_decimal(Roman, Fail, _),
	write("Actual Roman:"), write(ARoman), nl,
	write("Optimal found: "), write(Roman), nl,
	write("Optimal decimal: "), write(Fail), nl,
	write("Actual: "), write(Decimal), nl.

roman_to_decimal(Roman, Decimal, LengthRoman) :-
	atom_chars(Roman, Digits),
	length(Digits, LengthRoman),
	add_roman(Digits, 0, Decimal), !.

add_roman([X, Y, Z | Tail], Temp, Decimal) :-
	score(X, Num),
	score(Y, Num1),
	score(Z, Num2),
	Num2 > Num,
	Num2 > Num1,
	Temp1 is Temp + Num2 - Num - Num1,
	add_roman(Tail, Temp1, Decimal).

add_roman([X, Z | Tail], Temp, Decimal) :-
	score(X, Num),
	score(Z, Num1),
	Num >= Num1,
	Temp1 is Temp + Num,
	List = [Z | Tail],
	add_roman(List, Temp1, Decimal).

add_roman([X, Z | Tail], Temp, Decimal) :-
	score(X, Num),
	score(Z, Num1),
	Temp1 is Temp + Num1 - Num,
	add_roman(Tail, Temp1, Decimal).

add_roman([X], Temp, Decimal) :-
	score(X, Num),
	Decimal is Num + Temp.

add_roman([], X, X).

score(i, 1).
score(v, 5).
score(x, 10).
score(l, 50).
score(c, 100).
score(d, 500).
score(m, 1000).

optimal(Decimal, Roman, LengthOpt) :-
	build_roman(Decimal, [], RomanOptList),
	length(RomanOptList, LengthOpt),
	reverse(RomanOptList, X),
	atom_chars(Roman, X).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 1000,
	UpdateDecimal is Decimal - 1000,
	List = [m | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 900,
	UpdateDecimal is Decimal - 900,
	List = [m, c | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).


build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 500,
	UpdateDecimal is Decimal - 500,
	List = [d | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 400,
	UpdateDecimal is Decimal - 400,
	List = [d, c | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 100,
	UpdateDecimal is Decimal - 100,
	List = [c | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 90,
	UpdateDecimal is Decimal - 90,
	List = [c, x | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).


build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 50,
	UpdateDecimal is Decimal - 50,
	List = [l | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 40,
	UpdateDecimal is Decimal - 40,
	List = [l, x | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 10,
	UpdateDecimal is Decimal - 10,
	List = [x | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 9,
	UpdateDecimal is Decimal - 9,
	List = [x, i | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 5,
	UpdateDecimal is Decimal - 5,
	List = [v | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 4,
	UpdateDecimal is Decimal - 4,
	List = [v, i | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).
	
build_roman(Decimal, Temp, RomanOpt) :-
	Decimal >= 1,
	UpdateDecimal is Decimal - 1,
	List = [i | Temp],
	build_roman(UpdateDecimal, List, RomanOpt).

build_roman(0, RomanOpt, RomanOpt).
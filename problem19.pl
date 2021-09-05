next_month(jan, feb).
next_month(feb, mar).
next_month(mar, apr).
next_month(apr, maj).
next_month(maj, jun).
next_month(jun, jul).
next_month(jul, aug).
next_month(aug, sep).
next_month(sep, okt).
next_month(okt, nov).
next_month(nov, dec).
next_month(dec, jan).

same_month(jan, jan).
same_month(feb, feb).
same_month(mar, mar).
same_month(apr, apr).
same_month(maj, maj).
same_month(jun, jun).
same_month(jul, jul).
same_month(aug, aug).
same_month(sep, sep).
same_month(okt, okt).
same_month(nov, nov).
same_month(dec, dec).

n_days(jan, 31, _).

n_days(feb, N_DAYS, YEAR) :-
	0 is YEAR mod 100,
	0 is YEAR mod 400,
	N_DAYS = 29.
n_days(feb, N_DAYS, YEAR) :-
	0 is YEAR mod 4,
	X is YEAR mod 100,
	X =\= 0,
	N_DAYS = 29.
n_days(feb, 28, _).

n_days(mar, 31, _).
n_days(apr, 30, _).
n_days(maj, 31, _).
n_days(jun, 30, _).
n_days(jul, 31, _).
n_days(aug, 31, _).
n_days(sep, 30, _).
n_days(okt, 31, _).
n_days(nov, 30, _).
n_days(dec, 31, _).

days_in_year(YEAR, DAYS) :-
	0 is YEAR mod 4,
	X is YEAR mod 100,
	X =\= 0,
	DAYS = 366.
days_in_year(YEAR, DAYS) :-
	0 is YEAR mod 100,
	0 is YEAR mod 400,
	DAYS = 366.
days_in_year(_, 365).

days_in_years(YEAR, END_YEAR, CURRENT_DAYS, DAYS) :-
	YEAR is END_YEAR,
	DAYS is CURRENT_DAYS,
	!.
days_in_years(YEAR, END_YEAR, CURRENT_DAYS, DAYS) :-
	days_in_year(YEAR, X),
	Y is CURRENT_DAYS + X,
	Z is YEAR + 1,
	days_in_years(Z, END_YEAR, Y, DAYS).

days_to(_, MONTH, DAY, END_MONTH, END_DAY, N_DAYS, CURRENT_DAYS) :-
	same_month(MONTH, END_MONTH),
	DAY =:= END_DAY,
	N_DAYS = CURRENT_DAYS,
	!.
days_to(YEAR, MONTH, DAY, END_MONTH, END_DAY, N_DAYS, CURRENT_DAYS) :-
	same_month(MONTH, END_MONTH),
	X = END_DAY,
	Z is END_DAY - DAY,
	Y is CURRENT_DAYS + Z,
	days_to(YEAR, MONTH, X, END_MONTH, END_DAY, N_DAYS, Y). 
days_to(YEAR, MONTH, DAY, END_MONTH, END_DAY, N_DAYS, CURRENT_DAYS) :-
	DAY =:= END_DAY,
	n_days(MONTH, X, YEAR),
	Y is CURRENT_DAYS + X,
	next_month(MONTH, Z),
	days_to(YEAR, Z, DAY, END_MONTH, END_DAY, N_DAYS, Y).
days_to(YEAR, MONTH, DAY, END_MONTH, END_DAY, N_DAYS, CURRENT_DAYS) :-
	DAY < END_DAY,
	X is END_DAY - DAY,
	Y is CURRENT_DAYS + X,
	days_to(YEAR, MONTH, END_DAY, END_MONTH, END_DAY, N_DAYS, Y).
days_to(YEAR, MONTH, DAY, END_MONTH, END_DAY, N_DAYS, CURRENT_DAYS) :-
	n_days(MONTH, X, YEAR),
	next_month(MONTH, Z),
	T is X - (DAY - END_DAY),
	Y is CURRENT_DAYS + T,
	days_to(YEAR, Z, END_DAY, END_MONTH, END_DAY, N_DAYS, Y).



count_days(START_YEAR, START_MONTH, START_DAY, END_YEAR, END_MONTH, END_DAY, N_DAYS) :-
	days_to(END_YEAR, START_MONTH, START_DAY, END_MONTH, END_DAY, X, 0),
	days_in_years(START_YEAR, END_YEAR, 0, Y),
	N_DAYS is X + Y,
	!.

next_day(mon, tue).
next_day(tue, wen).
next_day(wen, tur).
next_day(tur, fri).
next_day(fri, sat).
next_day(sat, sun).
next_day(sun, mon).

same_day(mon, mon).
same_day(tue, tue).
same_day(wen, wen).
same_day(tur, tur).
same_day(fri, fri).
same_day(sat, sat).
same_day(sun, sun).

count_rest(DAY, 0, TEMP, DAYS) :-
	same_day(DAY, sun),
	DAYS is TEMP + 1,
	!.
count_rest(_, 0, DAYS, DAYS).
count_rest(DAY, REST, TEMP, DAYS) :-
	same_day(DAY, sun),
	next_day(DAY, X),
	Y is TEMP + 1,
	Z is REST - 1,
	count_rest(X, Z, Y, DAYS).
count_rest(DAY, REST, TEMP, DAYS) :-
	next_day(DAY, X),
	Z is REST - 1,
	count_rest(X, Z, TEMP, DAYS).

number_sundays(START_YEAR, START_MONTH, START_DAY, END_YEAR, END_MONTH, END_DAY, N_DAYS, WEEKDAY) :-
	count_days(START_YEAR, START_MONTH, START_DAY, END_YEAR, END_MONTH, END_DAY, X),
	Y is X mod 7,
	Z is X // 7,
	count_rest(WEEKDAY, Y, 0, REST),
	N_DAYS is Z + REST,
	!.
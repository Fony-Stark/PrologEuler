yearcode(Year, YearCC) :-
	LastTwoDigit is Year mod 100,
	X is LastTwoDigit // 4,
	Sum is X + LastTwoDigit,
	YearCC is Sum mod 7.

monthcode(jan, 0).
monthcode(feb, 3).
monthcode(mar, 3).
monthcode(apr, 6).
monthcode(maj, 1).
monthcode(jun, 4).
monthcode(jul, 6).
monthcode(aug, 2).
monthcode(sep, 5).
monthcode(okt, 0).
monthcode(nov, 3).
monthcode(dec, 5).

cencode(Year, 4) :-
	Year < 1800, !.
cencode(Year, 2) :-
	Year < 1900, !.
cencode(Year, 0) :-
	Year < 2000, !.
cencode(Year, 6) :-
	Year < 2100, !.
cencode(Year, 4) :-
	Year < 2200, !.
cencode(Year, 2) :-
	Year < 2300, !.
cencode(Year, 0) :-
	Year < 2400.

leapyear(Year, X) :-
	0 is Year mod 100,
	0 is Year mod 400,
	X is 1.
leapyear(Year, X) :-
	0 is Year mod 4,
	Z is Year mod 100,
	Z =\= 0,
	X is 1.
leapyear(_, 0).

whichday(0, sun).
whichday(1, mon).
whichday(2, tue).
whichday(3, wen).
whichday(4, tur).
whichday(5, fri).
whichday(6, sat).

same_day(mon, mon).
same_day(tue, tue).
same_day(wen, wen).
same_day(tur, tur).
same_day(fri, fri).
same_day(sat, sat).
same_day(sun, sun).

weekday(Year, Month, Day, Weekday) :-
	yearcode(Year, YearCC),
	monthcode(Month, MonthCC),
	cencode(Year, CenCC),
	leapyear(Year, LeapYearCC),
	X is YearCC + MonthCC + CenCC + Day - LeapYearCC,
	Z is X mod 7,
	whichday(Z, Weekday).

monthvalue(jan, 0).
monthvalue(feb, 2).
monthvalue(mar, 3).
monthvalue(apr, 4).
monthvalue(maj, 5).
monthvalue(jun, 6).
monthvalue(jul, 7).
monthvalue(aug, 8).
monthvalue(sep, 9).
monthvalue(okt, 10).
monthvalue(nov, 11).
monthvalue(dec, 12).

earlier(Year, _, _, Nyear, _, _) :-
	Year < Nyear, !.
earlier(Year, Month, _, Nyear, Nmonth, _) :-
	Year =:= Nyear,
	monthvalue(Month, X),
	monthvalue(Nmonth, Y),
	X < Y, !.
earlier(Year, Month, Day, Nyear, Nmonth, Nday) :-
	Year =:= Nyear,
	monthvalue(Month, X),
	monthvalue(Nmonth, Y),
	X =:= Y,
	Day < Nday, !.
earlier(Year, Month, Day, Nyear, Nmonth, Nday) :-
	Year =:= Nyear,
	monthvalue(Month, X),
	monthvalue(Nmonth, Y),
	X =:= Y,
	Day =:= Nday.

next_month(jan, X, feb, X).
next_month(feb, X, mar, X).
next_month(mar, X, apr, X).
next_month(apr, X, maj, X).
next_month(maj, X, jun, X).
next_month(jun, X, jul, X).
next_month(jul, X, aug, X).
next_month(aug, X, sep, X).
next_month(sep, X, okt, X).
next_month(okt, X, nov, X).
next_month(nov, X, dec, X).
next_month(dec, Year, jan, Nyear) :-
	Nyear is Year + 1.

countsundays(Syear, Smonth, SDay, Eyear, Emonth, Eday, Temp, Nsundays) :-
	earlier(Syear, Smonth, SDay, Eyear, Emonth, Eday),
	weekday(Syear, Smonth, SDay, X),
	same_day(sun, X),
	next_month(Smonth, Syear, Z, Y),
	T is Temp + 1,
	countsundays(Y, Z, 1, Eyear, Emonth, Eday, T, Nsundays).

countsundays(Syear, Smonth, SDay, Eyear, Emonth, Eday, Temp, Nsundays) :-
	earlier(Syear, Smonth, SDay, Eyear, Emonth, Eday),
	next_month(Smonth, Syear, Z, Y),
	countsundays(Y, Z, 1, Eyear, Emonth, Eday, Temp, Nsundays).

countsundays(_, _, _, _, _, _, X, X).

numbersundays(Syear, Smonth, SDay, Eyear, Emonth, Eday, Nsundays) :-
	SDay =:= 1,
	countsundays(Syear, Smonth, SDay, Eyear, Emonth, Eday, 0, Nsundays), !.
numbersundays(Syear, Smonth, _, Eyear, Emonth, Eday, Nsundays) :-
	next_month(Smonth, Syear, X, Y),
	countsundays(Y, X, 1, Eyear, Emonth, Eday, 0, Nsundays), !.
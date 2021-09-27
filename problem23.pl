emitco(D, _, D).
emitco(D, C, C) :-
    dif(D, C).

divisor(N, R) :-
    UB is floor(sqrt(N)),
    between(1, UB, D),
    0 is N mod D,
    C is N / D,
    emitco(D, C, R).

abundant(N) :-
	setof(D, divisor(N, D), Ds),
	sum_list(Ds, X),
	Sum is X - N,
	Sum > N.

all_abundant(X) :-
	between(1, 28123, X),
	abundant(X).

abundant_sum(List, Sum) :-
	member(X, List),
	member(Y, List),
	X >= Y,
	Sum is X + Y,
	Sum =< 28123.


charles(Answer) :-
	findall(I, all_abundant(I), Abudant),
	findall(X, between(1, 28123, X), Nums),
	findall(J, abundant_sum(Abudant, J), Abundant_sum),
	sort(Abundant_sum, ABC),
	sum_list(Nums, Sum),
	sum_list(ABC, ABCD),
	Answer is Sum - ABCD.
	
ispalindrome(N) :-
	number_chars(N, S),
	reverse(S,S).

isgood(A,B,X) :-
	X is A * B,
	ispalindrome(X).

answer(From, To, Answer) :-
	findall(X, (
		between(From,To,A),
		between(From,To,B),
		isgood(A,B,X)),
		PS),
	sort(PS, Sorted),
	reverse(Sorted, [Answer|_]).
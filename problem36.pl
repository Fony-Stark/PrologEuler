ispalindrome(N) :-
	number_chars(N, S),
	reverse(S,S).

dec2Bin(0,V,_,V).
dec2Bin(N,V,Counter,Val):-
    Reminder is N mod 2,
    N1 is N//2,
    V1 is V + Reminder*(10^Counter),
    Counter1 is Counter + 1,
    dec2Bin(N1,V1,Counter1,Val), !.

convert(N,V):-
    N > -1,
    dec2Bin(N,0,0,V).

find_number_palindroms_base10_and_base2(M, M, S, S).

find_number_palindroms_base10_and_base2(N, M, S, SN) :-
    ispalindrome(N),
    convert(N, V),
    ispalindrome(V),
    S1 is S + N,
    N1 is N + 1,
    find_number_palindroms_base10_and_base2(N1, M, S1, SN), !.

find_number_palindroms_base10_and_base2(N, M, S, SN) :-
    N1 is N + 1,
    find_number_palindroms_base10_and_base2(N1, M, S, SN), !.
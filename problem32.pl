numbers_atoms([],[]).

numbers_atoms([X|Y],[C|K]) :-
    atom_number(C, X),
    numbers_atoms(Y,K).

digits_number(Digits, Number) :-
    numbers_atoms(Digits, Atoms),
    number_codes(Number, Atoms).

charles(Sum) :-
    findall(Y, (permutation([1, 2, 3, 4, 5, 6, 7, 8, 9], Permutation), is_pandigital(Permutation, Y)), Xs),
    sort(Xs, Ys),
    sum_list(Ys, Sum).

is_pandigital(List_num, Res) :-
    between(1, 3, X),
    X1 is X + 1,
    between(X1, 5, Y),
    sub_string(List_num, 0, X, [], Left_side),
    sub_string(List_num, X, Y, [], Right_side),
    sub_string(List_num, Y, 9, [], Result),
    digits_number(Result, Res),
    digits_number(Left_side, Left),
    digits_number(Right_side, Right),
    Res is Left * Right, !.


sub_string(_,           End,    End, Result,    Result) :- !.
sub_string(Org_list,    Start,  End, Temp,      Result) :-
    Next is Start + 1,
    nth0(Start, Org_list, X),
    append(Temp, [X], Temp1),
    sub_string(Org_list, Next, End, Temp1, Result).
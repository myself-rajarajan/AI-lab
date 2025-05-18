% Main predicate to solve N-Queens
n_queens(N, Solution) :-
    range(1, N, Ns),
    permutation(Ns, Solution),
    safe(Solution).

% Generate a list from Low to High
range(Low, High, []) :- Low > High.
range(Low, High, [Low|Rest]) :-
    Low =< High,
    Next is Low + 1,
    range(Next, High, Rest).

% Check that no two queens are on the same diagonal
safe([]).
safe([Q|Others]) :-
    safe(Q, Others, 1),
    safe(Others).

safe(_, [], _).
safe(Q, [Q1|Others], D) :-
    abs(Q - Q1) =\= D,
    D1 is D + 1,
    safe(Q, Others, D1).

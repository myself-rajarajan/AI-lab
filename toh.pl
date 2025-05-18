% hanoi(NumberOfDisks, Source, Target, Auxiliary, Moves)
% Moves will be a list of moves like move(From, To)

hanoi(0, _, _, _, []) :- !.  % No move needed for zero disks

hanoi(N, Source, Target, Auxiliary, Moves) :-
    N > 0,
    N1 is N - 1,
    hanoi(N1, Source, Auxiliary, Target, Moves1),
    Moves2 = [move(Source, Target)],
    hanoi(N1, Auxiliary, Target, Source, Moves3),
    append(Moves1, Moves2, TempMoves),
    append(TempMoves, Moves3, Moves).

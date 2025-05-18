% Define the goal state
goal(state(_, 2)).

% Start the problem
solve :-
    move(state(0, 0), []).

% Move predicate with current state and visited states
move(State, Visited) :-
    goal(State),
    write('Solution path: '), nl,
    reverse([State|Visited], Path),
    print_path(Path).

move(State, Visited) :-
    \+ member(State, Visited),
    next(State, NextState),
    move(NextState, [State|Visited]).

% Possible moves
next(state(X, Y), state(4, Y)) :- X < 4.           % Fill 4-liter jug
next(state(X, Y), state(X, 3)) :- Y < 3.           % Fill 3-liter jug
next(state(X, Y), state(0, Y)) :- X > 0.           % Empty 4-liter jug
next(state(X, Y), state(X, 0)) :- Y > 0.           % Empty 3-liter jug

% Pour 4 -> 3
next(state(X, Y), state(NewX, NewY)) :-
    X > 0, Y < 3,
    Pour is min(X, 3 - Y),
    NewX is X - Pour,
    NewY is Y + Pour.

% Pour 3 -> 4
next(state(X, Y), state(NewX, NewY)) :-
    Y > 0, X < 4,
    Pour is min(Y, 4 - X),
    NewX is X + Pour,
    NewY is Y - Pour.

% Print the solution path
print_path([]).
print_path([H|T]) :-
    write(H), nl,
    print_path(T).

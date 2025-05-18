% state(MissionariesLeft, CannibalsLeft, BoatPosition, MissionariesRight, CannibalsRight)
% BoatPosition: left or right

% Start and goal states
start_state(state(3,3,left,0,0)).
goal_state(state(0,0,right,3,3)).

% Allowed moves: (M, C) people crossing
move(state(ML, CL, left, MR, CR), state(ML2, CL2, right, MR2, CR2)) :-
    transport(M, C),
    ML >= M, CL >= C,
    ML2 is ML - M, CL2 is CL - C,
    MR2 is MR + M, CR2 is CR + C,
    safe_state(ML2, CL2, MR2, CR2).

move(state(ML, CL, right, MR, CR), state(ML2, CL2, left, MR2, CR2)) :-
    transport(M, C),
    MR >= M, CR >= C,
    ML2 is ML + M, CL2 is CL + C,
    MR2 is MR - M, CR2 is CR - C,
    safe_state(ML2, CL2, MR2, CR2).

% Possible transport moves (1 or 2 people)
transport(2, 0).
transport(0, 2).
transport(1, 0).
transport(0, 1).
transport(1, 1).

% Check if state is safe
safe_state(ML, CL, MR, CR) :-
    (ML >= CL ; ML = 0),
    (MR >= CR ; MR = 0),
    ML >= 0, CL >= 0, MR >= 0, CR >= 0,
    ML =< 3, CL =< 3, MR =< 3, CR =< 3.

% Solve: path from Start to Goal, avoiding visited states
solve :-
    start_state(Start),
    goal_state(Goal),
    path(Start, [Start], Goal, Path),
    print_path(Path).

path(Goal, _, Goal, [Goal]).
path(State, Visited, Goal, [State|Path]) :-
    move(State, NextState),
    \+ member(NextState, Visited),
    path(NextState, [NextState|Visited], Goal, Path).

% Print the solution path
print_path([]).
print_path([H|T]) :-
    write(H), nl,
    print_path(T).

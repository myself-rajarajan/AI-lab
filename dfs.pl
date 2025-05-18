% Sample directed graph
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, e).
edge(d, f).
edge(e, f).

% DFS path finder
dfs(Start, Goal, Path) :-
    dfs_util(Start, Goal, [Start], Path).

% If current node is Goal, return path
dfs_util(Goal, Goal, Visited, Path) :-
    reverse(Visited, Path).

% Recursive DFS
dfs_util(Current, Goal, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),     % Avoid cycles
    dfs_util(Next, Goal, [Next|Visited], Path).

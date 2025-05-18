% Sample directed graph
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, e).
edge(d, f).
edge(e, f).

% BFS main predicate
bfs(Start, Goal, Path) :-
    bfs_queue([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

% BFS with a queue of paths
bfs_queue([[Goal|Rest]|_], Goal, [Goal|Rest]).  % Found goal

bfs_queue([CurrentPath|OtherPaths], Goal, Path) :-
    CurrentPath = [CurrentNode|_],
    findall([NextNode|CurrentPath],
            (edge(CurrentNode, NextNode),
             \+ member(NextNode, CurrentPath)),
            NextPaths),
    append(OtherPaths, NextPaths, NewQueue),
    bfs_queue(NewQueue, Goal, Path).

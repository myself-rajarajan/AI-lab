% Distances between cities (symmetric)
distance(a, b, 10).
distance(b, a, 10).
distance(a, c, 15).
distance(c, a, 15).
distance(a, d, 20).
distance(d, a, 20).
distance(b, c, 35).
distance(c, b, 35).
distance(b, d, 25).
distance(d, b, 25).
distance(c, d, 30).
distance(d, c, 30).

% Calculate the total distance of a given route
route_distance([_], 0).
route_distance([City1, City2 | Rest], Distance) :-
    distance(City1, City2, D),
    route_distance([City2 | Rest], DRest),
    Distance is D + DRest.

% TSP main predicate: find the shortest route starting and ending at Start
tsp(Start, Route, MinDistance) :-
    findall(City, (distance(Start, City, _), City \= Start), Cities),
    permutation(Cities, PermutedCities),
    RouteCandidate = [Start | PermutedCities],
    append(RouteCandidate, [Start], CompleteRoute),
    route_distance(CompleteRoute, Dist),
    assertz(temp_solution(Dist, CompleteRoute)),
    fail.

tsp(_, Route, MinDistance) :-
    retract(temp_solution(MinDistance, Route)),
    \+ (retract(temp_solution(D, _)), D < MinDistance).


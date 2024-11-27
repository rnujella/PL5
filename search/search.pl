%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pathfinding in search.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Search function that starts from the initial room and finds the treasure
search(Actions) :-
    initial(StartRoom),
    treasure(TreasureRoom),
    bfs([[state(StartRoom, [], [])]], TreasureRoom, Actions).

% Breadth-first search logic
bfs([[state(CurrentRoom, Keys, Path)|_]|_], TargetRoom, Actions) :-
    CurrentRoom = TargetRoom,
    reverse(Path, Actions).  % Reverse to show path in correct order

bfs([[state(CurrentRoom, Keys, Path)|Rest]|Queue], TargetRoom, Actions) :-
    findall(
        NextState,
        move_to_next(CurrentRoom, Keys, Path, NextState),
        NewStates
    ),
    append(Queue, NewStates, UpdatedQueue),
    bfs(Rest, TargetRoom, Actions).

% Define valid transitions between rooms
move_to_next(CurrentRoom, Keys, Path, state(NextRoom, Keys, [move(CurrentRoom, NextRoom)|Path])) :-
    door(CurrentRoom, NextRoom),
    (   locked_door(CurrentRoom, NextRoom, LockColor),
        member(LockColor, Keys)
    ;   \+ locked_door(CurrentRoom, NextRoom, _)
    ),
    \+ member(move(CurrentRoom, NextRoom), Path).

% Handle picking up keys
move_to_next(CurrentRoom, Keys, Path, state(CurrentRoom, [NewKey|Keys], [take(CurrentRoom, NewKey)|Path])) :-
    key(CurrentRoom, NewKey),
    \+ member(NewKey, Keys).

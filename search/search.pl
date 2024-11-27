search(Actions) :-
    initial(Start),
    treasure(Target),
    bfs([[state(Start, [], [])]], Target, Actions).

bfs([[state(Room, Keys, Path)|_]|_], Target, Actions) :-
    Room = Target,
    reverse(Path, Actions).

bfs([[state(Room, Keys, Path)|Rest]|Queue], Target, Actions) :-
    findall(
        NextState,
        move_to_next(Room, Keys, Path, NextState),
        NextStates
    ),
    append(Rest, NextStates, UpdatedQueue),
    bfs(UpdatedQueue, Target, Actions).

move_to_next(CurrentRoom, Keys, Path, state(NextRoom, Keys, [move(CurrentRoom, NextRoom)|Path])) :-
    door(CurrentRoom, NextRoom),
    (   locked_door(CurrentRoom, NextRoom, LockColor),
        member(LockColor, Keys)
    ;   \+ locked_door(CurrentRoom, NextRoom, _)
    ),
    \+ member(move(CurrentRoom, NextRoom), Path).

move_to_next(CurrentRoom, Keys, Path, state(CurrentRoom, [NewKey|Keys], [take(CurrentRoom, NewKey)|Path])) :-
    key(CurrentRoom, NewKey),
    \+ member(NewKey, Keys).

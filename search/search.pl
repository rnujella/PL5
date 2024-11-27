search(Actions) :-
    initial(Start),
    treasure(Target),
    write('Starting from room: '), write(Start), nl,
    write('Looking for treasure at room: '), write(Target), nl,
    bfs([[state(Start, [], [])]], Target, Actions).

bfs([[state(Room, Keys, Path)|_]|_], Target, Actions) :-
    Room = Target,
    write('Found treasure at room: '), write(Room), nl,
    reverse(Path, Actions).

bfs([[state(Room, Keys, Path)|Rest]|Queue], Target, Actions) :-
    write('Exploring room: '), write(Room), nl,
    write('Collected keys: '), write(Keys), nl,
    findall(
        NextState,
        move_to_next(Room, Keys, Path, NextState),
        NextStates
    ),
    write('Next possible states: '), write(NextStates), nl,
    append(Rest, NextStates, UpdatedQueue),
    bfs(UpdatedQueue, Target, Actions).

move_to_next(CurrentRoom, Keys, Path, state(NextRoom, Keys, [move(CurrentRoom, NextRoom)|Path])) :-
    door(CurrentRoom, NextRoom),
    (   locked_door(CurrentRoom, NextRoom, LockColor),
        member(LockColor, Keys)
    ;   \+ locked_door(CurrentRoom, NextRoom, _)
    ),
    write('Moving from room '), write(CurrentRoom), write(' to room '), write(NextRoom), nl,
    \+ member(move(CurrentRoom, NextRoom), Path).

move_to_next(CurrentRoom, Keys, Path, state(CurrentRoom, [NewKey|Keys], [take(CurrentRoom, NewKey)|Path])) :-
    key(CurrentRoom, NewKey),
    \+ member(NewKey, Keys),
    write('Picked up key: '), write(NewKey), nl.

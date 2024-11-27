%%%%%%%%%%%%%%%%%%%%%%
% Main Search Logic
%%%%%%%%%%%%%%%%%%%%%%

% Start the search
search(Actions) :-
    initial(Start),
    treasure(Goal),
    bfs([[state(Start, [], [])]], Goal, Actions).

% BFS: state(Room, Keys, ActionsSoFar)
bfs([[state(Room, Keys, Actions)|_]|_], Goal, Actions) :-
    Room = Goal,
    reverse(Actions, Actions). % Reverse the actions to return them in correct order
bfs([[state(Room, Keys, Actions)|Rest]|Queue], Goal, FinalActions) :-
    findall(
        NextState,
        next_state(Room, Keys, Actions, NextState),
        NextStates
    ),
    append(Rest, NextStates, UpdatedQueue),
    bfs(UpdatedQueue, Goal, FinalActions).

% Define possible transitions (next state)
next_state(Room, Keys, Actions, state(NextRoom, Keys, [move(Room, NextRoom)|Actions])) :-
    door(Room, NextRoom),
    (   locked_door(Room, NextRoom, LockColor),
        member(LockColor, Keys)
    ;   \+ locked_door(Room, NextRoom, _)
    ),
    \+ member(move(Room, NextRoom), Actions).

next_state(Room, Keys, Actions, state(Room, [KeyColor|Keys], [take_key(Room, KeyColor)|Actions])) :-
    key(Room, KeyColor),
    \+ member(KeyColor, Keys).

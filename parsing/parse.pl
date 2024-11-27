%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parser for a specific sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define valid parsing rules
parse([X|Xs]) :-
    parse_expression([X|Xs]).

% Base case for the parser: a simple number
parse_expression([Num|Rest]) :-
    number_string(_, Num),
    parse_more(Rest).

% Define a comma separated list after the first number
parse_more([',', X|Rest]) :-
    parse_expression([X|Rest]).
    
parse_more([;|Rest]) :-
    parse_more_statement(Rest).

% Parser for the semi-colon and further parts of the sequence
parse_more_statement([X|Rest]) :-
    number_string(_, X),
    parse_more(Rest).

parse_more([]).  % End of input

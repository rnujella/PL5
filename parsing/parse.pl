%%%%%%%%%%%%%%%%%
% Parsing Logic
%%%%%%%%%%%%%%%%%

parse(X) :-
    phrase(expression, X).

expression --> number, rest.

rest --> [','], expression.
rest --> [';'], expression.
rest --> [].

number --> [Token], { number_string(_, Token) }.

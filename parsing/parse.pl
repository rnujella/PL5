parse(Tokens) :-
    phrase(lines, Tokens).

lines --> line, [';'], lines.
lines --> line.

line --> num, [','], line.
line --> num.

num --> digit.
num --> digit, num.

digit --> ['0'].
digit --> ['1'].
digit --> ['2'].
digit --> ['3'].
digit --> ['4'].
digit --> ['5'].
digit --> ['6'].
digit --> ['7'].
digit --> ['8'].
digit --> ['9'].

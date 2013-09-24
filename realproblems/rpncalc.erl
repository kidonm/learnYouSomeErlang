-module(rpncalc).
-compile(export_all).

rpnCalc(Tokens) -> 
	lists:foldl(fun rpn/2, [], Tokens).

rpn("+", [O1 , O2 | T]) -> [O1 + O2 | T];
rpn("-", [O1 , O2 | T]) -> [O1 - O2 | T];
rpn("*", [O1 , O2 | T]) -> [O1 * O2 | T];
rpn("/", [O1 , O2 | T]) -> [O1 / O2 | T];
rpn(Token, Stack) -> [read(Token)|Stack].

read(Token) ->
	case string:to_float(Token) of
		{error, no_float} -> list_to_integer(Token);
		{F,_} -> F
	end.

rpn_test() ->
	1 = rpnCalc(["5", "4", "-"]).

	


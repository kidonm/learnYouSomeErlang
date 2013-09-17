-module(patternmatch).
-compile(export_all).

head([H|_]) -> H.

oh_god(N) -> 
	if N =:= 2 -> might_succeed;
		true -> always_does %% if elsee
	end.

insert(X, []) ->
	[X];
insert(X, Set) ->
	case lists:member(X,Set) of
		true -> Set;
		false -> [X | Set]
	end.



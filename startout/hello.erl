-module(hello).
-export([hello/0, greetings/1]).

hello() ->
	io:format("nazdar bazar~n").

greetings(Pozdrav) ->
	io:format(" ahoj s parametrem~n").

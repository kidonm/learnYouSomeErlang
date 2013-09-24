-module(links).
-compile(export_all).

proc1() ->
	timer:sleep(5000),
	exit(reason).

chain(0) ->
	receive
	after 2000 ->
		exit("chain ends here")
	end;

chain(N) ->
	link(spawn(fun() -> chain(N-1) end)),
	receive
		_ -> ok
	end.

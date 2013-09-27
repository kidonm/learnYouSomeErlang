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

spawn_critic() -> spawn(?MODULE, restarter, []).

restarter() ->
	process_flag(trap_exit, true),
	PID = spawn_link(?MODULE, critic, []),
	register(critic, PID),
	receive
		{'EXIT', PID, normal} ->
			ok;
		{'EXIT', PID, shutdown} ->
			ok;
		_ ->
			io:format("restartovan critic process"),
			restarter()	
	end.

critic() ->
		receive
				{From, Ref, {"Rage Against the Turing Machine", "Unit Testify"}} ->
					From ! {self(), "They are great!"};
				{From, Ref, {"System of a Downtime", "Memoize"}} ->
					From ! {self(), "They're not Johnny Crash but they're good."};
				{From, Ref, {"Johnny Crash", "The Token Ring of Fire"}} ->
					From ! {self(), "Simply incredible."};
				{From, Ref, {_Band, _Album}} ->
					From ! {self(), "They are terrible!"}
		end,
		critic().



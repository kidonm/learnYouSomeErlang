-module(event).
-compile(export_all).

-record(state, {server,
	name="",
	to_go=0}).


normalize(N) ->
	Limit = 49 * 24 * 60 * 60,
	[N rem Limit | lists:duplicate(N div Limit, Limit)].

loop(S = #state{server=Server,to_go=[H|T]}) ->
	receive
		{Server, Ref, cancel} ->
			Server ! {Ref, ok}
	after H * 1000 ->
		case T of 
			[] -> 
				io:format("exiting"),
				Server ! {done, S#state.name},
			_ -> 
				io:format("continue next"),
				loop(S#state{to_go=T})
		end
	end.

start(EventName, Delay) ->
	spawn(fun() ->	init(self(), EventName, Delay) end).

start_link(EventName, Delay) ->
	spawn_link(fun() ->	init(self(), EventName, Delay) end).

init(Pid, EventName, Delay) ->
	loop(#state{server=Pid,
			name=EventName,
			to_go=[5,5]}).

cancel(Pid) ->
	Ref = erlang:monitor(process, Pid),
	Pid ! {self(), Ref, cancel},
	receive
		{Ref, ok} ->
			erlang:demonitor(Ref, [flush]),
			ok;
		{'DOWN', Ref, process, Pid, _Reason} ->
			ok
	end.

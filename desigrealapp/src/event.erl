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
				Server ! {done, S#state.name};
			_ -> 
				loop(S#state{to_go=T})
		end
	end.

start(EventName, Delay) ->
	spawn(?MODULE, init, [self(), EventName, Delay]).

start_link(EventName, Delay) ->
	spawn_link(?MODULE, init, [self(), EventName, Delay]).

init(Pid, EventName, Delay) ->
	loop(#state{server=Pid,
			name=EventName,
			to_go=normalize(Delay)}).

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

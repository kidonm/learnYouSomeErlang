-module(evserv).
-compile(export_all).

-record(state, {events,
		clients}).

-record(event, {name="",
		description="",
		pid,
		timeout={{1970,1,1},{0,0,0}}}).

init() ->
	loop(#state{events=orddict:new(),
				clients=orddict:new()}).	

loop(S=#state{}) ->
	receive
		{Pid, MsgRef, {subscribe, Client}} ->
			Ref = erlang:monitor(process, Client),
			NewClients = orddict:store(Ref, Client, S#state.clients),
			Pid ! {MsgRef, ok},
			loop(S#state{clients=NewClients});

		{Pid, Ref, {add, Name, Desc, TimeOut}} ->
			EventPid = event:start_link(Name,Timeout),
			NewEvents = orddict:store(Name, 
				#event{name=Name,
					description=Desc,
					pid=EventPid,
					timeout=TimeOut},
				S#state.events),
			Pid ! {MsgRef, ok},
			loop(#state{clients=NewEvents});

		{Pid, Ref, {cancel, Name}} ->
			Events = case orddict:find(Name,S#state.events) of
				{ok, E} ->
					event:cancel(E#event.pid),
					orddict:erase(Name,S#state.events);
				error ->
					#state.events
			end,
			Pid ! {Ref, ok},
			loop(S#sate{events=Events});

		{Done, Name} ->
			Events = case orddict:find(name, S#state.events) of
				{ok, E} ->
					sendToClients({done, E#event.name, E#event.description,
							S#state.clients}),
					orddict:erase(Name,S#state.events);
				error ->
					#state.events;
			end,

			loop(S#state.{events=Events}).

		shutdown ->
		{'DOWN', Ref ,process ,_Pid, _Reason} ->
		code_change ->
		Unknown ->
			io:format("got unknown message: ~p ~n", [Unknown]),
			loop(State)
	end.

sendToClients(Msg, ClientDict) ->
	orddict:map( fun(_Ref, Pid) -> Pid ! Msg end, ClientDict).

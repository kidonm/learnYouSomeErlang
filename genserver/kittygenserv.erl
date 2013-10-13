-module(kittygenserv).
-behaviour(gen_server).
-compile(export_all).

-record(cat, {name, color=green, description}).

make_cat(Name, Col, Desc) ->
	#cat{name=Name, color=Col, description=Desc}.

start_link() -> gen_server:start_link(?MODULE, [], []).
order_cat(Pid, Name, Color, Description) ->
	gen_server:call(Pid, {order, Name, Color, Description}).

return_Cat(Pid, Cat = #cat{}) ->
	gen_server:cast(Pid, {return, Cat}).

close_shop(Pid) ->
	gen_server:call(Pid, terminate).

init([]) -> {ok, []}.

handle_call({order, Name, Color, Description}, _From, Cats) ->
	case Cats of 
		[] ->
			{reply, make_cat(Name, Color, Description), Cats};
		_ ->
			{reply, hd(Cats), tl(Cats)}
	end;

handle_call(terminate, _From, Cats) ->
	{stop, normal, ok, Cats}.

handle_cast({return, Cat = #cat{}}, Cats) ->
	{noreply, [Cat | Cats]}.

handle_info(_Msg, Cats) ->
	io:format('unrecognized message'),
	{noreply, Cats}.

terminate(normal, Cats) ->
	[io:format("~p was set free.~n", [C#cat.name]) || C <- Cats],
	ok.

code_change(_Old, State, _Extra) -> 
	{ok, State}.

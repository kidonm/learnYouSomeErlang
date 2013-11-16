-module(my_db_gen).
-behaviour(gen_server).
-compile(export_all).


start() ->
	gen_server:start({local, ?MODULE}, ?MODULE, [],[] ).

stop() ->
	gen_server:cast(?MODULE, stop).

init(_Args) ->
	io:format("stopping the server~n", []),
	{ok, []}.

handle_call(print, _From, State) ->
	{reply, State,  State};

handle_call({write, Data}, _From, State) ->
	{reply, ok,  lists:append(State, Data)};

handle_call({delete, Data}, _From, State) ->
	Reply = case lists:delete(Data, State) of
		State ->
			{error, instance};
		_ ->
			{ok, Data}
	end,
	{reply, Reply, Reply}.

terminate(_Reason, _State) ->
	io:format("exiting the server ~n", []).

handle_cast(stop, State) ->
	{stop, normal, State}.

print()->
	gen_server:call(?MODULE, print).

write(Data) ->
	gen_server:call(?MODULE, {write, Data}).

delete(Data) ->
	gen_server:call(?MODULE, {delete, Data}).

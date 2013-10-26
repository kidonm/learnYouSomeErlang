-module(ppool_serv).
-behaviour(gen_server).




start_link(Name, Limit, Sup, MFA) when is_atom(Name), is_integer(Limit) ->
		gen_server:start_link({local, Name}, ?MODULE, {Limit, MFA, Sup}, []).

run(Name, Args) ->
	gen_server:call(Name, {run, Args}).

sync_queue(Name, Args) ->
	gen_server:call(Name, {sync, Args}, infinity).

async_queue(Name, Args) ->
	gen_server:cast(Name, {async, Args}).

stop(Name) ->
	gen_server:call(Name, stop).



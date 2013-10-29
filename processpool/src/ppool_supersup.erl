-module(ppool_supersup).
-behaviour(supervisor).
-compile(export_all).

start_link() ->
	supervisor:start_link({local, ppool}, ?MODULE, []).

stop() ->
	case whereis(ppool) of
		P when is_pid(P) ->
			exit(p, kill);
		_ ->
			ok
	end.

init([]) ->
	MaxRestart = 6,
	MaxTime = 3600,
	{ok, {{one_for_one, MaxRestart, MaxTime}, []}}.

start_pool(Name, Limit, MFA) ->
	ChildSpec = {Name, 
				{ppool_sup, start_link, [Name, Limit, MFA]},
				permanent, 10500, supervisor, [ppool_sup]},
	supervisor:start_child(ppool, ChildSpec).

stop_pool(Name) ->
	supervisor:terminate_child(ppool, Name),
	supervisor:delete_child(ppool, Name).





-module(client_database_testclient).
-behaviour(gen_fsm).
-export([start_link/0, init/1]).

start_link() ->
	gen_fsm:start_link({local, ?MODULE},?MODULE, [], []).

init([]) ->
	{ok, idle, []}.

idle() ->
	{next_state, idle, []}.
	

-module(client_database_testclient).
-behaviour(gen_fsm).
-export([start_link/1, init/1]).

start_link(Args) ->
	gen_fsm:start_link(?MODULE, [], []).

init([]) ->
	{ok, idle, []}.

idle() ->
	{next_state, idle, []}.
	

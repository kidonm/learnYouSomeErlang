-module(client_database_clientpool_supervisor).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
	supervisor:start_link(?MODULE,[] ).

init([]) ->
	{ok,{{one_for_all,1,1}, []}}.

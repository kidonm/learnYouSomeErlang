-module(client_database_clientpool_supervisor).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE} ,?MODULE,[] ).

init([]) ->
	VirtualClientSpecs = 
		{
			virtualClient,
			{
				client_database_testclient,
				start_link,
				[]
			},
			temporary,
			2000,
			worker,
			[client_database_testclient]
		},
	{ok,{{simple_one_for_one, 1, 1},[VirtualClientSpecs]}}.

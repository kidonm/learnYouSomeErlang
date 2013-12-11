-module(client_database_supervisor).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
	supervisor:start_link(?MODULE, []).

init([]) ->
	MyTab = ets:new(genericClientETS, [named_table]),
	% server which will receive requests for spawning generic client
	ClientDatabaseServer = 
		{
			clientDatabServer,
			{
				client_database_server,
				start_link,
				[self(), 
				MyTab,
				client_database_clientpool_supervisor]
			},
			permanent,
			2000,
			worker,
			[client_database_server]
		},

	% supervisor which will handle generic clients
	ClientPoolSup = 
		{
			clientPoolSup, 
			{
				client_database_clientpool_supervisor,
				start_link,
				[]
			},
			permanent, 
			2000,
			supervisor,
			[client_database_clientpool_supervisor]
		},
	{ok,{{one_for_all,1,1}, [ClientDatabaseServer, ClientPoolSup]}}.

	

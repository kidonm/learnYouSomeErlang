-module(database_supervisor).
-behaviour(supervisor).

start_link() ->
	supervisor:start_link(?MODULE, []).

init(_Args):
	MyTab = ets:new(genericClientETS, [named_table]),
	ClientDatabaseServer = 
		{
			clientDatabServer,
			{
				client_database_server,
				start_link,
				[self(), MyTab]
			},
			permanent,
			2000,
			worker,
			[client_database_server]
		}
	{ok,{{one_for_all,1,1}, [ClientDatabaseServer]}}

	

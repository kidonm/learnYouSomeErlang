-module(client_database_server).
-behaviour(gen_server).

-record(state, 
	{
		parentSupPID, 	
		clientTable,
		clientpoolSupPID
	}).

start_link([SupervisorPID, ETSTable]) ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [SupervisorPID, ETSTable], []).

init([SupervisorPID, ETSTable]) ->
	ClientPoolSup = 
		{
			clientPool, 
			{
				clientpool_supervisor,
				start_link,
				[]
			},
			permanent, 
			2000,
			supervisor,
			[clientpool_supervisor]
		},
	{ok, #state
		{
			parentSupPID = SupervisorPID,
			clientTable = ETSTable,
			clientpoolSupPID = supervisor:start_child(SuperVisorPID, ClientPoolSup)
		}

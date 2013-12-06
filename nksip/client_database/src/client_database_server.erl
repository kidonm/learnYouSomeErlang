-module(client_database_server).
-behaviour(gen_server).
-export([start_link/3, init/1]).

-record(state, 
	{
		parentSupPID, 	
		clientTable,
		clientpoolSupPID
	}).

start_link(SupervisorPID, ETSTable, ClientPoolSup) ->
	gen_server:start_link({local, ?MODULE}, ?MODULE,
	 {
		SupervisorPID, ETSTable, ClientPoolSup
	 }, []).

init({SupervisorPID, ETSTable, ClientPoolSup}) ->
	io:format('tttt~n', []),

	{ok, #state
		{
			parentSupPID = SupervisorPID,
			clientTable = ETSTable,
			clientpoolSupPID = ClientPoolSup
		}
	}.

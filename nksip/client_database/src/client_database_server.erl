-module(client_database_server).
-behaviour(gen_server).
-export([start_link/3, init/1, addNewClient/1]).

-record(state, 
	{
		parentSupPID, 	
		clientTable,
		clientpoolSupPID
	}).

addNewClient(Data) ->
	gen_server:call(?MODULE, Data).	

start_link(SupervisorPID, ETSTable, ClientPoolSup) ->
	gen_server:start_link({local, ?MODULE}, ?MODULE,
	 {
		SupervisorPID, ETSTable, ClientPoolSup
	 }, []).

init({SupervisorPID, ETSTable, ClientPoolSup}) ->

	{ok, #state
		{
			parentSupPID = SupervisorPID,
			clientTable = ETSTable,
			clientpoolSupPID = ClientPoolSup
		}
	}.

handle_call({add_client, _From}, _From,_State) ->
	io:format("TTTT", []),
	%VirtualClientSpecs = 
	%	{
	%		clientpoolClient,
	%		{
	%			client_database_testclient,
	%			start_link,
	%			[]
	%		},
	%		temporary,
	%		2000,
	%		worker,
	%		[client_database_testclient]
	%	},
	%{reply,supervisor:start_child(TargetPID, VirtualClientSpecs) , State}.
	{reply,"blabla", _State}.
	

-module(client_database_server).
-behaviour(gen_server).
-export([start_link/3, init/1, addNewClient/1, listClient/1]).
-export([handle_call/3, handle_info/2, terminate/2, code_change/3]).

-record(state, 
	{
		parentSupPID, 	
		clientTable,
		clientpoolSupPID
	}).

addNewClient(Data) ->
	gen_server:call(?MODULE, Data).	

listClient(From) ->
	gen_server:call(?MODULE, From).

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

terminate(Reason, _State) ->
	io:format("reason to terminate ~p ", [Reason]),
	ok.

code_change(_Old, State, _Extr) ->
	{ok, State}.


handle_call({list}, _From, State=#state{clientTable=Table}) ->
	{reply, ets:match(Table, {'$1', '$2'}), State};

handle_call({add_client, Ident}, _From, State=#state{clientpoolSupPID=TargetPID,
	clientTable=ClientTable}) ->

	Resp = case ets:lookup(ClientTable, Ident) of
		[{Ident, Value }] -> 
				{already_started, Value};

		[] -> 
	 		case supervisor:start_child(TargetPID, [Ident]) of
				{ok, PID} ->
					true = ets:insert(ClientTable, {Ident, PID}),
					{ok, PID};

				{error, {already_started, PID}} -> {already_started, PID};

				{error, _ErrorTerm} -> {error, _ErrorTerm}
			end;

		_ -> {error, "multiple items in table under given key"}
	end,



	{reply, Resp, State}.

handle_info(_Info, State) ->
	{noreply, State}.
	

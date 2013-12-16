-module(client_database).
-behaviour(application).
-export([start_link/0, addClient/1, listClient/0]).

start_link() ->
	client_database_supervisor:start_link().

addClient(From) ->
	client_database_server:addNewClient({add_client, From}).	

listClient() ->
	client_database_server:listClient({list}).


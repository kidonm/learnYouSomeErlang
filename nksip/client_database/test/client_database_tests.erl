-module(client_database_tests).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

start_test() ->
	?assertMatch({ok, _ }, client_database:start_link()).

%adds a client in
add_client_test() ->
	?assertMatch({ok, _}, client_database:addClient(client1)).

list_clients_test() ->
	client_database:start_link(),
	client_database:addClient(client1),
	?assertMatch( [[_, _ ]], client_datbase:listClient()).

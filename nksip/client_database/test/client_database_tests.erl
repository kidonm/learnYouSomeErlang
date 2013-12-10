-module(client_database_tests).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

start_test() ->
	?assertMatch({ok, _ }, client_database:start_link()).

add_client_test() ->
	?assertMatch()

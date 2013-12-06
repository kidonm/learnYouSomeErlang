-module(client_database).
-behaviour(application).
-export([start_link/0]).

start_link() ->
	client_database_supervisor:start_link().


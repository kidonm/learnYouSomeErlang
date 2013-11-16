-module(my_db_app).
-behaviour(application).
-compile(export_all).

start(_Type, _Args) ->
	my_db_sup:start_link().

stop(_State) ->
	ok.


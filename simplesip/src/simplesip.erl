-module(simplesip).
-behaviour(gen_server).
-compile(export_all).

-record(request, {method=register,
		from="",
		to="",
		expires=0}).

-record(response, {code="",
		from="",
		to=""}).

-record(client, {pid="",
		name=""}).

simplesip_register(From, To) ->
	makeRegisterRequest(From, To).

simplesip_unregister() ->
	makeUnregisterRequest(From, To).
simplesip_call() ->

init([]) -> {ok. []}.
start_link() -> gen_server:start_link(?MODULE, [], []). 


init() -> {}



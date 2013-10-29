-module(ppool).
-compile(export_all).

start_link(normal, _Args) ->
	ppool_supersup:start_link().
 
stop() ->
	ok.
 
start_pool(Name, Limit, {M,F,A}) ->
	ppool_supersup:start_pool(Name, Limit, {M,F,A}).
 
stop_pool(Name) ->
	ppool_supersup:stop_pool(Name).
 
run(Name, Args) ->
	ppool_serv:run(Name, Args).
 
async_queue(Name, Args) ->
	ppool_serv:async_queue(Name, Args).
 
sync_queue(Name, Args) ->
	ppool_serv:sync_queue(Name, Args).

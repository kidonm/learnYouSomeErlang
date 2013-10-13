-module(simplesip).
-behaviour(gen_server).
-compile(export_all).

-record(request, {method=register,
		from="",
		to=""}).

-record(response, {code="",
		from="",
		to=""}).

-record(client, {pid="",
		name=""}).


init() -> {}



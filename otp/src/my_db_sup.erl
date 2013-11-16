-module(my_db_sup).
-behaviour(supervisor).
-compile(export_all).


start_link() ->
	supervisor:start_link({local,?MODULE}, ?MODULE, []).

init(_Args) ->
	SupSpec = {
		one_for_all,
		1,
		1	
	},

	ChildSpec = {
		datab,
		{
			my_db_gen,
			start,
			[]
		},
		permanent,
		30,
		worker,
		[usr_db_gen]
	},

	{
		ok,
		{
			SupSpec,
			[ChildSpec]
		}
	}.

{application, my_db,
	[
		{description, "just a simple database"},
		{vsn, "1.0"},
		{modules, [my_db_gen, my_db_sup, my_db_app]},
		{registered, [my_db_gen, my_db_sup, my_db_app]},
		{applications, [kernel, stdlib]},
		{env, []},
		{mod, {my_db_app, []}}
	]
}.

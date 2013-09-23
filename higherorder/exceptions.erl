-module(exceptions).
-compile(export_all).

throws(F) ->
	try(F) of
		_ -> ok
	catch
		Throw -> {throw, caught, Throw}
	end.

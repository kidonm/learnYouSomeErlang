-module(dolphins).
-compile(export_all).

dolphins() ->
	receive
		{Sender,flip} ->
			Sender ! "how bout no ?";
		{Sender,fish} ->
			Sender ! "gimme beef idiot !";
		_ ->
			io:format("something else")
	end.

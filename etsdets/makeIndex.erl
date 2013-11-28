-module(makeIndex).
-compile(export_all).

-define(PUNCTUATION, "(\\ |\\,|\\.\\;|\\:|\\t|\\n|\\(|\\))+").

index(File) ->
	ets:new(indexTable, [ordered_set, named_table]),
	processFile(File),
	prettyIndex().

processFile(File) ->
	{ok, IOHandle} = file:open(File, [read]),
	processLine(IOHandle, 1).

processLines(IOHandle, N) ->
	case io:get_line(IOHandle, "") of
		eof ->
			ok;
		Line ->
			processLine(Line, N),
			processLines(IOHandle, N+1)
	end.

processLine(Line, N) ->
	io:fwrite(Line, []),
	case re:split(Line, ?PUNCTUATION) of
		{ok, Words} ->
			processWords(Words, N);
		 _ -> 
			[]
	end.	

processWords(Words, N) ->
	case Words of
		[] ->
			ok;
		[Word|Rest] ->
			if length(Word) > 3 ->
					Normalise = string:to_lower(Word),
					ets:insert(indexTable, {{Normalise, N}});
				true -> ok
			end,
			processWords(Rest, N)
	end.
	
prettyIndex() ->
	"asd".

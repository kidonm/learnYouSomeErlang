-module(kitchen).
-compile(export_all).


fridge(FoodList) ->
	receive
		{From, {put, Food}} ->
			From ! {self(),{stored, Food}},
			fridge([Food | FoodList]);
		{From, {take, Food}} ->
			case lists:member(Food, FoodList) of
				true ->
					From ! {self(), {taken, Food}},
					fridge(FoodList);
				false ->
		_
			-> io:format("unknown operation")
	end.

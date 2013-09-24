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
					fridge(lists:delete(Food,FoodList));
				false ->
					From ! {self(), {notfound, Food}},
					fridge(FoodList)
			end;
		terminate -> 
			ok
	end.

start() ->
	spawn(?MODULE, fridge, [[]]).

store(PID, Food) ->
	PID ! {self(), {put, Food}},
	receive
		{PID, Msg} -> Msg
	after 3000 ->
			timeout
	end.

take(PID, Food) ->
	PID ! {self(), {take, Food}},
	receive
		{PID, Msg} -> Msg
	after 3000 ->
			timeout
	end.

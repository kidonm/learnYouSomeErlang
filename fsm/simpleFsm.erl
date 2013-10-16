-module(simpleFsm).
-behaviour(gen_fsm).
-compile(export_all).
%-export([ start_link/1, , press_star/1, type_pass/2, press_sharp/1, block_door/1]).

start_link(Code) ->
	gen_fsm:start_link({local, dvere}, ?MODULE, Code, []).

init(Code) ->
	{ok, idle, Code}.

press_star(DoorPid) ->
	gen_fsm:send_event(DoorPid, {pressedStar}).

type_pass(DoorPid, Pass) ->
	gen_fsm:send_event(DoorPid, {password, Pass, self()}).

press_sharp(DoorPid) ->
	gen_fsm:send_all_state_event(DoorPid, {pressedSharp}).

block_door(DoorPid) ->
	gen_fsm:send_all_state_event(DoorPid, {stop}).

handle_event({stop}, _StateName, StateDate) ->
	{stop, normal, StateDate};

handle_event({pressedSharp}, _StateName, StateDate) ->
	io:format("pressed sharp"),
	{next_state, idle, StateDate}.

idle({pressedStar}, Code) ->
	io:format("enter code"),
	{next_state, wait_pass, Code, 10000};

idle( _ , Code) ->
	io:format("press * and then your code"),
	{next_state, idle, Code}.

wait_pass(timeout, Code) ->
	io:format("no password entered. timeout"),
	{next_state, idle, Code};

wait_pass({password, Pass, Pid}, Code) ->
	case Pass of
		Code -> 
			Pid ! {access_granted},
			{next_state, unlock, Code, 30000};
		_ ->
			Pid ! {access_denied},
			{next_state, idle, Code}
	end.

unlock(timeout, Code) ->
	io:format("the door is locked again"),
	{next_state, idle, Code}.









	




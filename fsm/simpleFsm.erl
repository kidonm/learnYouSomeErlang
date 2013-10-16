-module(simpleFsm).
-behaviour(gen_fsm).
-compile(export_all).

start_link(Code) ->
	gen_fsm:start_link({local, simpleFsm}, simpleFsim, Code).

init(Code) ->
	{ok, idle, [Code]}.

press_star(DoorPid) ->
	gen_fsm:send_event(DoorPid, {pressedStar}, 30000).

type_pass(DoorPid, Pass) ->
	gen_fsm:send_event(DoorPid, {password, Pass, self()}, 30000).

press_sharp(DoorPid) ->
	gen_fsm:send_event(DoorPid, {pressedSharp}).

idle({pressedStar}, Code) ->
	io:format("enter code"),
	{next_state, wait_pass, Code};

idle( _ , Code) ->
	io:format("press * and then your code"),
	{next_state, idle, Code }.


wait_pass({password, Pass, Pid}, Code) ->
	case Pass of
		Code -> 
			Pid ! {access_granted},
			{next_state, unlock_doors, Code};
		_ ->
			Pid ! {access_denied},
			{next_state, idle, Code}
	end.

unlock(timeout, Code) ->
	format:io("the door is locked again"),
	{next_state, idle, Code}.









	




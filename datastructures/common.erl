-module(common).
-compile(export_all).

-record(robot, {name,
		type=industrial,
		hobbies,
		details=[]}).

gimmeRobot() ->
	#robot{name="Mechatron",
		type=handmade,
		hobbies=["kill all humans", "chess champion"],
		details=["moved by small man inside"]}.

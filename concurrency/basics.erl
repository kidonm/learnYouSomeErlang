-module(basics).
-conpile(export_all).


F = fun() -> "hahahaha" end.

tralala() -> 
	spawn(F).

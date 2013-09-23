-module(start).
-compile(export_all).

map(_, []) -> [];
map(Func, [X|XS]) -> [Func(X)| map(Func, XS)].

increment(Num) -> Num + 1.

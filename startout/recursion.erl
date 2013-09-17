-module(recursion).
-compile(export_all).

len([]) -> 0;
len([_|T]) -> 1 + len(T). 

tail_fac(N) -> tail_fac(N, 1).
tail_fac(0, Acc) -> Acc;
tail_fac(N,Acc) -> tail_fac(N-1, N*Acc).

tail_len([]) -> 0;
tail_len(N) -> tail_len(N, 0).
tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc + 1).

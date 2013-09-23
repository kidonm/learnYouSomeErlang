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

duplicate(0,_) -> [];
duplicate(N,Term) -> [Term | duplicate(N-1, Term)].

tail_duplicate(N, Term) -> tail_duplicate(N, Term, []).
tail_duplicate(0,_,Acc) -> Acc;
tail_duplicate(N,Term,Acc) -> tail_duplicate(N-1, Term, [Term | Acc]).

reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

tail_reverse(List) -> tail_reverse(List, []).
tail_reverse([], Acc) -> Acc;
tail_reverse([H|T], Acc) -> tail_reverse(T, [H|Acc]). 

sublist([], _) -> [];
sublist(_, 0) -> [];
sublist([H|T], Num) -> [H|sublist(T, Num -1)].


tail_sublist(L, N) -> tail_sublist(L,N,[]).
tail_sublist([], _, Acc) -> Acc;
tail_sublist(_, 0, Acc) -> Acc;
tail_sublist([H|T], N, Acc) -> tail_sublist(T, N-1, Acc ++ [H]). 


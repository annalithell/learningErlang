-module(recursive).
-export([fac/1, len/1, tail_fac/1, tail_fac/2, tail_len/1, tail_len/2, lc_quickSort/1]).

%%fac(N) when N == 0 -> 1;
%%fac(N) when N > 0 -> N*fac(N-1).

fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N-1).

%% length of list
len([]) -> 0;
len([_|T]) -> 1 + len(T).

%% ´tail recursive faculty function
tail_fac(N) -> tail_fac(N,1).

tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0-> tail_fac(N-1,N*Acc).

%% tail recursive length function
tail_len(L) -> tail_len(L,0).
tail_len([],Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T,Acc+1).

%% QuickSort
lc_quickSort([]) -> [];
lc_quickSort([Pivot|Rest]) ->
    lc_quickSort([Smaller || Smaller <- Rest, Smaller =< Pivot])
    ++[Pivot] ++
    lc_quickSort([Larger || Larger <- Rest, Larger > Pivot]). %% use lists:sort/1 instead
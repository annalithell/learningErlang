-module(tut).
-compile(export_all).
%-export([spawnCounter/1, counter/1]).

spawnCounter(N) -> 
    spawn(fun () -> counter(N) end).

counter(N) ->
    receive inc -> counter(N+1);
        {print,S} -> io:format("~p" ++ S, [N]),
            counter(N)
    end.

spawnMultiplier(N) ->
    spawn (fun () ->
            multiplier(N) end).

multiplier(N) ->
    receive {mul, M} ->
            multiplier(N*M);
        {get, From, Ref} -> From ! {N,Ref}, % return N to the sender
            multiplier(N)
    end.

get(Multiplier) ->
    Ref = make_ref(),
    Multiplier ! {get,self(),Ref},
    receive {N, Ref} -> % pattern match on messages in inbox
            N
    end. 

spawnGenserver(StateF, InitState) ->
    spawn(fun () -> genserverLoop(StateF, InitState) end).

genserverLoop(F,S) ->
    receive{Msg,From,Ref} ->
            {Reply, S2} = F(S,Msg), % S2 successor of S
            From ! {Reply,Ref},
            genserverLoop(F,S2)
    end.

%passed as arg to spawnGenserver
counterHandler(N,inc) ->
    {ok, N+1};
counterHandler(N,{print,Str}) ->
    io:format("~p" ++ Str ++ "~n",[N]), 
    {ok, N}.

%  ! is used to send data to another process
send(GS,Msg) ->
    From = self(),
    Ref = make_ref(),
    GS ! {Msg,From,Ref},
    receive {Reply, Ref} ->
        Reply
    end.

ctr_print(Ctr,S) ->
    send(Ctr,{print,S}).

% self() returns your own pid
% make_ref() 
-module(functions).
-export([head/1, second/1, same/2, valid_time/1, heh_fine/0, oh_god/1, beach/1]). 

head([H|_]) -> H.

second([_,S|_]) -> S.

same(X,X) ->
    true;
same(_,_) ->
    false.

%% unbound values: variables without any attached values

valid_time({Date = {Y,M,D}, Time = {H,Min,S}}) ->
    io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n",[Date,Y,M,D]),
    io:format("The time tuple (~p) indicates: ~p:~p:~p.~n",[Time,H,Min,S]);
valid_time(_) ->
    io:format("Stop feeding me wrong data! ~n").

heh_fine() ->
    if 1 =:= 1 ->
        works
    end,
    if 1 =:= 2; 1 =:= 1 -> 
        works
    end,
    if 1 =:= 2, 1 =:= 1 -> %% no match ever, will always be evaluated to false
        fails
    end. 

oh_god(N) ->
    if N =:= 2 -> might_succeed;
        true -> always_does
    end.    

beach(Temperature) ->
    case Temperature of
        {celsius, N} when N >= 20, N =< 45 ->
            'favorable';
        {kelvin, N} when N >= 68, N =< 113 ->
            'favorable in the US';
        _ ->
            'avoid beach'
    end. 
-module(fib_seq).
-export([fib/1]).

%% Erlang tutorial

%% commands in shell:
%% q(). terminating an Erlang shell
%% Ctrl+G then i<Enter>, c<Enter>. Interrupts running thread

%fib(0) -> 1;                    % semi colons separate different clauses
%fib(N) when N =:= 1 -> 1;
%fib(N) when N > 1 -> fib(N-1) + fib(N-2);
%fib(N) when N < 1 -> fib(N+1) + fib(N+2).

fib(N) when N =:= 0 -> 1;
fib(1) -> 1;
fib(N) ->
    Pid = self(),
    spawn(fun () -> Pid ! fib(N-1) end),
    spawn(fun () -> Pid ! fib(N-2) end),
    receive
        ResultA -> 
            receive
                ResultB -> ResultA + ResultB
            end
    end.

% spawn(name of module, name of function, # of arguments)

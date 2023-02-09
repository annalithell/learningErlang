-module(useless).
-export([add/2, hello/0, greet_and_add_two/1]).

add(A,B) ->
    A + B.

%% Shows greetings.
%% io:format/1 is the standard function used to output text.
hello() -> 
    io:format("Hello World!~n").

greet_and_add_two(X) ->
    hello(),
    add(X,2).

%% -define(MACRO, some_value).
-define(sub(X,Y), X-Y).

%% cd ("C:\Users\annal\.vscode\TDA384-PCP\learningErlang").
%% c(useless). 
%% useless:add(7,2).

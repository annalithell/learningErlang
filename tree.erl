-module(tree).
-export([empty/0, insert/3, lookup/2]).

empty() -> {node, 'leaf'}.

%% insert in tree

insert(Key, Val, {node, 'leaf'}) ->
    {node,{Key, Val, {node, 'leaf'}, {node, 'leaf'}}};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey < Key ->
    {node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey > Key ->
    {node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};
    
insert(Key, Val, {node, {Key, _, Smaller, Larger}}) ->
    {node, {Key, Val, Smaller, Larger}}.

%% lookup tree

lookup(_,{node, 'leaf'}) ->
    undefined;
lookup(Key, {node, {Key, Val, _,_}}) ->
    {ok, Val};
lookup(Key, {node, {NodeKey, _, Smaller, _}}) when Key < NodeKey ->
    lookup(Key, Smaller);
lookup(Key, {node, {_,_,_, Larger}}) ->
    lookup(Key, Larger).
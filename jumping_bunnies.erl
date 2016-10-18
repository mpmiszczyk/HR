%% Test timed out.
%% https://www.hackerrank.com/challenges/jumping-bunnies

%% Input:
%% 10
%% 597 322 187 734 498 215 176 451 114 204
%%
%% Output:
%% 1467174839068147440


-module(jumping_bunnies).
-export([main/0]).

main() ->
    {ok,[Count]} = io:fread("","~d"),
    Numbers = [begin 
                {ok, [Num]} = io:fread("","~d"),
                Num
              end || _X <- lists:seq(1,Count)],
    Multiply = lists:foldl(fun common_multiply/2, 1, Numbers),
    io:format("~p", [Multiply]).

common_multiply(A,B) ->
    common_multiply(A,B,A,B).

common_multiply(_A,_B, MultiA, MultiB) when MultiA =:= MultiB ->
    MultiA;
common_multiply( A, B, MultiA, MultiB) when MultiA < MultiB ->
    common_multiply( A, B, MultiA + A, MultiB);
common_multiply( A, B, MultiA, MultiB) when MultiB < MultiA ->
    common_multiply( A, B, MultiA, MultiB + B).

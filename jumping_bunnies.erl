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
  (A div gcd(A,B)) * B.


gcd(0,B) ->
  B;
gcd(A,B) when B > A ->
  gcd(B,A);
gcd(A,B) ->
  gcd(A rem B, B).



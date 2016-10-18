% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module('common-divisors').
-export([main/0,
         run/5,
         common_divisors/2]).


main() ->
  {ok, [Cases]} = io:fread("","~d"),
  Refs = [start_common_divisors() || _X <- lists:seq(1,Cases)],
  print_line_by_line([receive_results(Ref) || Ref <- Refs]).


start_common_divisors() ->
  {ok, [A,B]} = io:fread("","~d ~d"),
  spawn_process(?MODULE, common_divisors, [A,B]).


spawn_process(Module, Function, Arguments) ->
  spawn_link(?MODULE, run, [Module, Function, Arguments, self(), Ref = make_ref()]),
  Ref.

run(Module, Function, Arguments, Parent, Ref) ->
  Parent ! {Ref, erlang:apply(Module, Function, Arguments)}.

receive_results(Ref) ->
  receive {Ref, Results} ->
      Results
  end.
  
print_line_by_line(List) ->
  io:format(lists:flatten(lists:duplicate(length(List), "~w~n")),
            List).

%% To slow

common_divisors(A,B) when A < B->
  common_divisors(B, A);
common_divisors(A, B) ->
  length([X || X <- lists:seq(1, A) , 
               A rem X =:= 0,
               B rem X =:= 0]).


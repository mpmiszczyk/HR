% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module('common-divisors').
-export([main/0,
         run/5,
         common_divisors_count/2]).

%% TODO reimplement with gcd and factorization
%% TODO why I din't thought about GCD
%% TODO HR colours once again.


main() ->
  {ok, [Cases]} = io:fread("","~d"),
  Refs = [start_common_divisors() || _X <- lists:seq(1,Cases)],
  print_line_by_line([receive_results(Ref) || Ref <- Refs]).


start_common_divisors() ->
  {ok, [A,B]} = io:fread("","~d ~d"),
  spawn_process(?MODULE, common_divisors_count, [A,B]).


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


common_divisors_count(A,B) ->
  FactA = factorials(A),
  FactB = factorials(B),
  Common = FactA -- (FactA -- FactB),
  Freq = freq(Common),
  Permutations = lists:foldl(fun(X, Acc) ->
                                 Acc* (X+1)
                             end, 1, maps:values(Freq)),
  Permutations.




factorials(A) ->
  Primes = get_primes_up_to(math:sqrt(A)),
  factorials(A, Primes, []).

factorials(A,[Prime|PrimeTail],Acc) when A rem Prime =:= 0 ->
  factorials(A div Prime, [Prime|PrimeTail], [Prime|Acc]);

factorials(A,[Prime|PrimeTail], Acc) when A rem Prime =/= 0 ->
  factorials(A, PrimeTail, Acc);
factorials(1,[], Acc) ->
  Acc;
factorials(A,[], Acc) ->
  [A|Acc].



get_primes_up_to(Limit) ->
  get_primes_up_to(Limit, _Start = 3, _Primes = [2]).

get_primes_up_to(Limit, Iter, Acc) when Iter > Limit ->
  Acc;
get_primes_up_to(Limit, Iter, Acc) ->
  case lists:any(fun _DivisibelBy (A) ->
                     Iter rem A =:= 0
                 end, Acc) of
    true ->
      get_primes_up_to(Limit, Iter+1, Acc);
    false ->
      get_primes_up_to(Limit, Iter+1, [Iter|Acc])
  end.

freq(Numbers) ->
  lists:foldl(fun (X, Acc) ->
                  Acc#{ X => maps:get(X, Acc, 0)+1}
              end, #{}, Numbers).

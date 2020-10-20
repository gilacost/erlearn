-module(solution_01).

-export([main/0]).

solve_me_first(A, B) ->
    A + B.

main() ->
    {ok, [A, B]} = io:fread("", "~d~d"),
    Res = solveMeFirst(A, B),
    io:format("~p~n", [Res]).

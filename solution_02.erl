-module(solution_02).
-export([main/0]).
-import(os, [getenv/1]).

%
% Complete the simpleArraySum function below.
%
simpleArraySum(Ar) ->
    lists:sum(Ar).

read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);

read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [string:chomp(io:get_line("")) | Acc]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {ArCount, _} = string:to_integer(string:chomp(io:get_line(""))),

    ArTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Ar = lists:map(fun(X) -> {I, _} = string:to_integer(X), I end, ArTemp),

    Result = simpleArraySum(Ar),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.

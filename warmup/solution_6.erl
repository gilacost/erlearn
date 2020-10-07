-module(solution_06).
-export([main/0]).
-import(os, [getenv/1]).

% Complete the plusMinus function below.
plusMinus(Arr) ->
     Len = length(Arr),

    {Pos, Neg, Zero}=lists:foldr(fun(Element, {AccPos, AccNeg, AccZero}) ->
                                         case Element of
                                             N when N > 0 -> {1+AccPos, AccNeg, AccZero};
                                             N when N < 0 -> {AccPos, 1+AccNeg, AccZero};
                                             N when N == 0 -> {AccPos, AccNeg, 1+AccZero}
                                         end
                         end, {0, 0, 0}, Arr),

    lists:map(fun(X) ->
                    NumStr = io_lib:format("~.6f",[X/Len]),
                    Line = "~s~n",
                    io:fwrite(io_lib:format(Line, [NumStr]))

              end, [Pos, Neg, Zero]).



read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);
read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [string:chomp(io:get_line("")) | Acc]).

main() ->
    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    ArrTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Arr = lists:map(fun(X) -> {I, _} = string:to_integer(X), I end, ArrTemp),

    plusMinus(Arr),

    ok.
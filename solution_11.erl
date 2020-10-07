-module(solution_11).

-export([main/0]).

% Complete the countApplesAndOranges function below.
countApplesAndOranges(S, T, A, B, Apples, Oranges) ->
    ApplesCount = countFruit(Apples, S, T, A),
    OrangesCount = countFruit(Oranges, S, T, B),

    Line = "~w~n~w",
    io:fwrite(io_lib:format(Line, [ApplesCount, OrangesCount])).

countFruit(Fruits, S, T, TreePos) ->
    lists:foldl(
        fun(X, Acc) ->
            FruitPos = TreePos + X,
            InSamsHouse = (FruitPos >= S) and (FruitPos =< T),
            if
                InSamsHouse == true ->
                    Acc + 1;
                true ->
                    Acc
            end
        end,
        0,
        Fruits
    ).

main() ->
    St = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    {S, _} = string:to_integer(lists:nth(1, St)),

    {T, _} = string:to_integer(lists:nth(2, St)),

    Ab = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    {A, _} = string:to_integer(lists:nth(1, Ab)),

    {B, _} = string:to_integer(lists:nth(2, Ab)),

    Mn = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    {M, _} = string:to_integer(lists:nth(1, Mn)),

    {N, _} = string:to_integer(lists:nth(2, Mn)),

    ApplesTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Apples = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ApplesTemp
    ),

    OrangesTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Oranges = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        OrangesTemp
    ),

    countApplesAndOranges(S, T, A, B, Apples, Oranges),

    ok.

-module(solution_14).

-export([main/0]).

-import(os, [getenv/1]).

breakingRecords(Scores) ->
    {_, Max, Min} =
        lists:foldl(
            fun(Score, {PrevScoresAcc, BreakMaxCount, BreakMinCount}) ->
                if
                    length(PrevScoresAcc) == 0 ->
                        ScoresAcc = PrevScoresAcc ++ [Score],
                        {ScoresAcc, BreakMaxCount, BreakMinCount};
                    true ->
                        CurrentMin = lists:min(PrevScoresAcc),
                        CurrentMax = lists:max(PrevScoresAcc),
                        {BMaxC, BMinC} =
                            if
                                CurrentMax < Score ->
                                    {BreakMaxCount + 1, BreakMinCount};
                                true ->
                                    if
                                        CurrentMin > Score ->
                                            erlang:display("estoy loco"),
                                            erlang:display(CurrentMin),
                                            erlang:display(Score),
                                            {BreakMaxCount, BreakMinCount + 1};
                                        true ->
                                            {BreakMaxCount, BreakMinCount}
                                    end
                            end,

                        ScoresAcc = PrevScoresAcc ++ [Score],

                        {ScoresAcc, BMaxC, BMinC}
                end
            end,
            {[], 0, 0},
            Scores
        ),
    erlang:display([Min, Max]),
    [Max, Min].

read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);
read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [string:chomp(io:get_line("")) | Acc]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    ScoresTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Scores = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ScoresTemp
    ),

    Result = breakingRecords(Scores),

    io:fwrite(Fptr, "~s~n", [lists:join(" ", lists:map(fun(X) -> integer_to_list(X) end, Result))]),

    file:close(Fptr),

    ok.

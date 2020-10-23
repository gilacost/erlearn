-module(solution_21).

-export([main/0, page_count/2]).

-import(os, [getenv/1]).

% int n: the number of pages in the book
% int p: the page number to turn to
%
page_count(N, P) ->
    LeftPages = lists:seq(0, N, 2),
    RightPages = lists:seq(1, N + 1, 2),

    Book = lists:zip(LeftPages, RightPages),

    FromLeft = lists:foldl(
        fun(PPair, PagesTurned) ->
            case PPair of
                {LPage, RPage} when LPage < P, RPage < P -> PagesTurned + 1;
                _ -> PagesTurned
            end
        end,
        0,
        Book
    ),

    FromRight = lists:foldr(
        fun(PPair, PagesTurned) ->
            case PPair of
                {LPage, RPage} when LPage > P, RPage > P -> PagesTurned + 1;
                _ -> PagesTurned
            end
        end,
        0,
        Book
    ),
    lists:min([FromLeft, FromRight]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    {P, _} = string:to_integer(string:chomp(io:get_line(""))),

    Result = page_count(N, P),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.

-module(second).

-export([main/0, readlines/1]).

main() -> "main".

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

ocurrences(List, El, string) -> length([X || X <- List, [X] =:= El),

parse([], Buffer) ->
    Buffer;
parse([<<>>], Buffer) ->
    Buffer;
parse([<<H/binary>> | T], Buffer) ->
    {Number, <<>>} = string:to_integer(H),
    parse(T, [Number | Buffer]).

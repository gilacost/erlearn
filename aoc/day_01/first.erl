-module(first).

-export([main/0, readlines/1]).

main() -> "main".

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).

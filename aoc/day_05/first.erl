-module(first).

-export([main/0, readlines/1]).

main() ->
    Lines = readlines("input_example"),
    erlang:display(Lines).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

row(<<>>, {_Initial, Final}) ->
    Final;
row(<<H, T/binary>>, {Initial, Final}) ->
    row(T, upper_lower(<<H>>, Initial, Final)).

column(<<>>, {_Initial, Final}) ->
    Final;
column(<<H, T/binary>>, {Initial, Final}) ->
    row(T, upper_lower(<<H>>, Initial, Final)).

upper_lower(<<"B">>, Initial, Final) ->
    {ceil((Initial + Final) / 2), Final};
upper_lower(<<"F">>, Initial, Final) ->
    {Initial, (Final + Initial) div 2};
upper_lower(<<"R">>, Initial, Final) ->
    {ceil((Initial + Final) / 2), Final};
upper_lower(<<"L">>, Initial, Final) ->
    {Initial, (Final + Initial) div 2}.

parse([<<>>], Buffer) ->
    lists:reverse(Buffer);
parse([<<Row:7/binary, Column:3/binary>> | T], Buffer) ->
    RowCalc = row(Row, {0, 127}),
    ColCalc = column(Column, {0, 7}),
    Id = (RowCalc * 8) + ColCalc,
    parse(T, [{RowCalc, ColCalc, Id} | Buffer]).

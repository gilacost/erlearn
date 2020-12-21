-module(series).

-export([slices/2]).

slices(SliceLength, Series) when SliceLength =< 0 ->
    erlang:error("Slice length can't be 0 or negative", {0, Series});
slices(SliceLength, Series) when Series == [] ->
    erlang:error("Series can't be an empty list", {SliceLength, Series});
slices(SliceLength, Series) ->
    SeriesLength = length(Series),

    if
        SeriesLength >= SliceLength ->
            ChunksList = lists:seq(0, SeriesLength),
            Result = lists:map(
                fun(Pos) ->
                    Chunk = string:slice(Series, Pos, SliceLength),
                    string:trim(Chunk)
                end,
                ChunksList
            ),
            LastListElement = lists:last(Result),
            lists:filter(
                fun(El) ->
                    length(El) == SliceLength
                end,
                if
                    LastListElement == [] -> lists:droplast(Result);
                    true -> Result
                end
            );
        true ->
            erlang:error("Slice length bigger than series", {SliceLength, Series})
    end.

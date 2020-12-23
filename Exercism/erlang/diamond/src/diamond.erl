-module(diamond).

-export([rows/1, abecedary/0]).

rows(Letter) ->
    Letters = (abecedary() -- string:find(abecedary(), Letter)) ++ Letter,
    LettersLength = length(Letters),
    Top = lists:map(
        fun(L) ->
            pad([L], LettersLength)
        end,
        Letters
    ),
    Top ++ lists:reverse(lists:droplast(Top)).

pad(Str, Length) when Str == "A" ->
    LeftPad = lists:flatten(string:pad(Str, Length, leading, " ")),
    RightPad = lists:flatten(string:pad("", Length - 1, trailing, " ")),
    string:concat(LeftPad, RightPad);
pad(Str, Length) ->
    LetterPos = string:str(abecedary(), Str) - 1,
    LeftPad = lists:flatten(string:pad(Str, Length - LetterPos, leading, " ")),
    RightPad = lists:flatten(string:pad("", LetterPos, trailing, " ")),

    First = string:concat(LeftPad, RightPad),
    string:concat(First, string:reverse(lists:droplast(First))).

abecedary() ->
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ".

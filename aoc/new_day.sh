#!/bin/bash

DAY=$(printf "%02d" $1)
DIR=day_$DAY
SESSION_ID=${2:-53616c7465645f5f4b4159acacaebe68fe6d71fad6f2bbd9b56abcd7529c4994a362e9a3dee4c05802e53dee831cc530}

echo $DAY
echo $DIR
echo $SESSION_ID

create ()
{
cat > $1 <<EOF
-module($2).

-export([main/0, readlines/1]).

main() ->
    Lines = readlines("input"),
    erlang:display(Lines).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, []).

ocurrences(List, El, string) -> length([X || X <- List, [X] =:= El),

even_print([]) ->
    [];
even_print([H | T]) when H rem 2 /= 0 ->
    even_print(T);
even_print([H | T]) ->
    io:format("printing: ~p~n", [H]),
    [H | even_print(T)].

parse([<<>>], Buffer) ->
    Buffer;
parse([<<H/binary>> | T], Buffer) ->
    {Number, <<>>} = string:to_integer(H),
    parse(T, [Number | Buffer]).
EOF

cat > $DIR/rebar.config <<EOF
%% Erlang compiler options
{erl_opts, [debug_info, warnings_as_errors]}.

{dialyzer, [
    {warnings, [underspecs, no_return]},
    {get_warnings, true},
    % top_level_deps | all_deps
    {plt_apps, top_level_deps},
    {plt_extra_apps, []},
    % local | "/my/file/name"
    {plt_location, local},
    {plt_prefix, "rebar3"},
    {base_plt_apps, [stdlib, kernel, crypto]},
    % global | "/my/file/name"
    {base_plt_location, global},
    {base_plt_prefix, "rebar3"}
]}.

%% eunit:test(Tests)
{eunit_tests, []}.

%% Options for eunit:test(Tests, Opts)
{eunit_opts, [verbose]}.

%% == xref ==

{xref_warnings, true}.

%% xref checks to run
{xref_checks, [
    undefined_function_calls,
    undefined_functions,
    locals_not_used,
    exports_not_used,
    deprecated_function_calls,
    deprecated_functions
]}.

{project_plugins, [erlfmt]}.

{erlfmt, [
    write,
    {files, "**/*.{hrl,erl}"}
]}.
EOF
}


mkdir -p $DIR
create $DIR/first.erl "first"
create $DIR/second.erl "second"
cd $DIR

curl "https://adventofcode.com/2020/day/$1/input" \
  -H "cookie: session=$SESSION_ID" \
  --compressed -O input

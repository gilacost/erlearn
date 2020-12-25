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

main() -> "main".

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).

EOF
}

mkdir -p $DIR
create $DIR/first.erl "first"
create $DIR/second.erl "second"
cd $DIR

curl "https://adventofcode.com/2020/day/$1/input" \
  -H "cookie: session=$SESSION_ID" \
  --compressed -O input

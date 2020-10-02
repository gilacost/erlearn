#!/bin/bash


rm ./*.beam

next=$(($1+1))

echo $next

cp solution_${1}.erl solution_$next.erl

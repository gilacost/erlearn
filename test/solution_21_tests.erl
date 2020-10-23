-module(solution_21_tests).

-include_lib("eunit/include/eunit.hrl").

page_count_0_test() ->
    PageCount = solution_21:page_count(6, 2),
    ?assert(PageCount =:= 1).

page_count_1_test() ->
    PageCount = solution_21:page_count(5, 4),
    ?assert(PageCount =:= 0).

page_count_2_test() ->
    PageCount = solution_21:page_count(4, 4),
    ?assert(PageCount =:= 0).

page_count_3_test() ->
    PageCount = solution_21:page_count(5, 1),
    ?assert(PageCount =:= 0).

page_count_4_test() ->
    PageCount = solution_21:page_count(2059, 117),
    ?assert(PageCount =:= 58).

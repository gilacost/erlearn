# Open the interactive erlang shell
erl


Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Eshell V11.0.2  (abort with ^G)
1> pwd().
/Users/pepo/Repos/hackerl_rank
ok
2> c(solution).
{error,non_existing}
3> c(solution).
{ok,solution}
:4> solution:main().

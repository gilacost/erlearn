test: clean
		erl -make
		rebar3 eunit

clean:
		rm -fv **/*.beam

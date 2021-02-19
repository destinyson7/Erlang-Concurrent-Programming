-module('2018114005_2').

-export([main/1, bellman_ford/5, init/2, v_loop/4, merge_distances/2, len/3, start/3, distributed_bellman_ford/3, e_loop/2, relax/4]).

relax(S, T, W, Distance) ->
	DS = lists:nth(S, Distance),
	DT = lists:nth(T, Distance),

	% io:fwrite("~p ~p ~p ~p ~p\n", [DS, DT, S, T, W]),

	if
		DT > DS + W ->
			lists:sublist(Distance, T - 1) ++ [DS + W] ++ lists:nthtail(T, Distance);
		true -> Distance
	end.

e_loop([], Distance) -> Distance;
e_loop(Adj, Distance) ->
	[H | T] = Adj,
	{U, V, W} = H,
	e_loop(T, relax(V, U, W, relax(U, V, W, Distance))).

distributed_bellman_ford(Rank, Init, Adj) ->
	receive
		{'distance', Distance} ->
			Init ! {'distance', e_loop(Adj, Distance)},
			distributed_bellman_ford(Rank, Init, Adj);

		{'completed', true} -> ok
	end.

start(Rank, M, P) ->
	Each = M div P,
	Rem = M rem P,

	1 + Rank * Each + min(Rem, Rank).

len(Rank, M, P) ->

	Each = M div P,
	Rem = M rem P,

	if
		Rank < Rem ->
			Each + 1;

		Rank >= Rem ->
			Each
	end.

merge_distances(RootDistance, 0) ->
	RootDistance;

merge_distances(RootDistance, P) ->
	receive
		{'distance', Distance} ->
			merge_distances([min(D1, D2) || {D1, D2} <- lists:zip(RootDistance, Distance)], P - 1)
	end.

v_loop(Adj, Distance, Pids, P) ->

	lists:foreach(fun(Pid) -> Pid ! {'distance', Distance} end, Pids),
	RootDistance = e_loop(Adj, Distance),
	NewDistance = merge_distances(RootDistance, P - 1),

	% lists:foreach(fun(I) -> io:fwrite("~p ~p\n", [I, lists:nth(I, NewDistance)]) end, lists:seq(1, length(Distance))),

	if
		NewDistance == Distance ->
			lists:foreach(fun(Pid) -> Pid ! {'completed', true} end, Pids),
			Distance;

		true -> v_loop(Adj, NewDistance, Pids, P)
	end.

init(Src, Src) -> 0;
init(_, _) -> 1000000000.

bellman_ford(Adj, Src, N, M, P) ->
	Distance = [init(X, Src) || X <- lists:seq(1, N)],

	% lists:foreach(fun(I) -> io:fwrite("~p ~p\n", [I, lists:nth(I, Distance)]) end, lists:seq(1, N)).

	Pids = [spawn(?MODULE, distributed_bellman_ford, [Rank, self(), lists:sublist(Adj, start(Rank, M, P), len(Rank, M, P))]) || Rank <- lists:seq(1, P - 1)],

	ShortestDistance = v_loop(lists:sublist(Adj, start(0, M, P), len(0, M, P)), Distance, Pids, P),
	ShortestDistance.

main(Args) ->
	[Input, Output] = Args,

	{ok, Fd} = file:open(Input, [read]),
	{ok, [P]} = io:fread(Fd, [], "~d"),
	{ok, [N, M]} = io:fread(Fd, [], "~d ~d"),
	Adj = [{U, V, W} || {ok, [U, V, W]} <- [io:fread(Fd, [], "~d ~d ~d") || _ <- lists:seq(1, M)]],
	{ok, [Src]} = io:fread(Fd, [], "~d"),
	file:close(Fd),

	ShortestDistance = bellman_ford(Adj, Src, N, M, P),
	{ok, Fd2} = file:open(Output, [write]),
	lists:foreach(fun(I) -> io:format(Fd2, "~p ~p\n", [I, lists:nth(I, ShortestDistance)]) end, lists:seq(1, N)),
	file:close(Fd2).

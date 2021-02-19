-module('2018114005_2').

-compile(export_all).

relax(S, T, W, Distance) ->
    DS = lists:nth(S, Distance),
    DT = lists:nth(T, Distance),

    % io:fwrite("~p ~p ~p ~p ~p\n", [DS, DT, S, T, W]),
    if DT > DS + W ->
           lists:sublist(Distance, T - 1) ++
               [DS + W] ++ lists:nthtail(T, Distance);
       true -> Distance
    end.

e_loop([], Distance) -> Distance;
e_loop(Adj, Distance) ->
    [H | T] = Adj,
    {U, V, W} = H,

    e_loop(T, relax(V, U, W, relax(U, V, W, Distance))).

v_loop(Adj, Distance) ->
    NewDistance = e_loop(Adj, Distance),

    % lists:foreach(fun (I) ->
    %                       io:fwrite("~p ~p\n", [I, lists:nth(I, NewDistance)])
    %               end,
    %               lists:seq(1, length(Distance))),
    if NewDistance == Distance -> Distance;
       true -> v_loop(Adj, NewDistance)
    end.

init(Src, Src) -> 0;
init(_, _) -> 1000000000.

bellman_ford(Adj, Src, N) ->
    Distance = [init(X, Src) || X <- lists:seq(1, N)],
    % lists:foreach(fun (I) ->
    %                       io:fwrite("~p ~p\n", [I, lists:nth(I, Distance)])
    %               end,
    %               lists:seq(1, N)),
    ShortestDistance = v_loop(Adj, Distance),
    ShortestDistance.

main() ->
    N = 4,
    Adj = [{2, 4, 1},
           {3, 4, 1},
           {1, 4, 3},
           {1, 2, 1},
           {1, 3, 1}],
    Src = 1,

    ShortestDistance = bellman_ford(Adj, Src, N),
    lists:foreach(fun (I) ->
                          io:fwrite("~p ~p\n",
                                    [I, lists:nth(I, ShortestDistance)])
                  end,
                  lists:seq(1, N)).

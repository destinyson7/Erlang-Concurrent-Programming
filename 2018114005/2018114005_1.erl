-module('2018114005_1').

-export([main/1, receive_token/1, send_token/5, write/4]).

write(To, From, Token, Fd) ->
    io:format(Fd, "Process ~p received token ~p from process ~p.~n", [To, Token, From]).

receive_token(Fd) ->
    receive
        {From, To, Token} ->
            write(To, From, Token, Fd)
    end.

send_token(Rank, P, Token, Init, Fd) ->
    if
        Rank > 0 ->
            receive_token(Fd);

        Rank == 0 ->
            ok
    end,

    if
        Rank < P - 1 ->
            Pid = spawn(?MODULE, send_token, [Rank + 1, P, Token, Init, Fd]);

        Rank == P - 1 ->
            Pid = Init
    end,

    Pid ! {Rank, (Rank + 1) rem P, Token}.

main(Args) ->
    [Input, Output] = Args,

	{ok, Fd} = file:open(Input, [read]),
	{ok, [P, M]} = io:fread(Fd, [], "~d~d"),
	file:close(Fd),

	{ok, Fd2} = file:open(Output, [write]),
    spawn(?MODULE, send_token, [0, P, M, self(), Fd2]),
    receive_token(Fd2),
	file:close(Fd2).

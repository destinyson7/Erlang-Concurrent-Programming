-module('2018114005_1').

-export([main/1,
         receive_token/0,
         send_token/4,
         write/3]).

write(To, From, Token) ->
    io:format("Process ~p received token ~p from process "
              "~p.~n",
              [To, Token, From]).

receive_token() ->
    receive {From, To, Token} -> write(To, From, Token) end.

send_token(Cur, P, Token, Init) ->
    if Cur > 0 -> receive_token();
       Cur == 0 -> ok
    end,
    if Cur < P - 1 ->
           Pid = spawn(?MODULE,
                       send_token,
                       [Cur + 1, P, Token, Init]);
       Cur == P - 1 -> Pid = Init
    end,
    Pid ! {Cur, (Cur + 1) rem P, Token}.

main(Args) ->
    [P, M] = Args,
    spawn(?MODULE, send_token, [0, P, M, self()]),
    receive_token().

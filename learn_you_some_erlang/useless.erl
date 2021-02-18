-module(useless).

-export([add/2, greet_and_add_two/1, hello/0]).

add(A, B) -> A + B.

hello() -> io:format("Hello, world!~n").

greet_and_add_two(X) ->
    hello(),
    add(X, 2).

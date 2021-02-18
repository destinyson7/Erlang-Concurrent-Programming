-module(tut).

% -export([add/2, add/3, hello_world/0]).
-export([main/0]).

% hello_world() -> io:fwrite("Hello World\n").

% add(A, B) ->
%     hello_world(),
%     A + B.

% add(A, B, C) ->
%     hello_world(),
%     A + B + C.

main() -> what_grade(10).

preschool() -> 'Go to preschool'.

kindergarten() -> 'Go to kindergarten'.

grade_school() -> 'Go to grade school'.

what_grade(X) ->
    if X < 5 -> preschool();
       X == 5 -> kindergarten();
       X > 5 -> grade_school()
    end.

% compare(A, B) ->
%     Age = 18,
%     (Age >= 5) or (Age =< 12).

% do_math(A, B) ->
%     % A + B.
%     % A - B.
%     % A * B.
%     % A / B.
%     % A div B.
%     % A rem B.
%     % math:exp(1).
%     % math:log(2.71828182845904509080).
%     % math:log10(1000).
%     % math:sqrt(100).
%     rand:uniform(10).


#!/bin/bash

while :
do
    ./make_test
    erl -noshell -s 2018114005_2 main in.txt output.txt -s init stop
    ./checker
done;

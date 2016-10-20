#!/usr/bin/env bash
problem=jumping_bunnies

inputs=(
"3
2 3 4"
"3
3 3 2"
"2
1 3"
"10
597 322 187 734 498 215 176 451 114 204")

outputs=(
"12"
"6"
"3"
"1467174839068147440")



run_erl () {
module=$1
std_in=$2

erl -sname HackerRank@localhost -noshell -run $module main -run init stop <<< "$std_in"
}


for i in "${!inputs[@]}"
do
    out=$(run_erl $problem "${inputs[$i]}")
    if [[ "${outputs[$i]}" != "$out" ]]
    then
        echo "bad results"
        echo ">>> in:"
        echo "${inputs[$i]}"
        echo ">>> out: "
        echo "$out"
        echo ">>> should:"
        echo ${outputs[$i]}
        exit 2
    fi
    echo ">>> out:"
    echo $out
done

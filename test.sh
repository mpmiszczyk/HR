
problem=$1

inputs=(
"3
10 4
1 100
288 240"
'1
10 4')

outputs=(
"2
1
10"
"2")



run_erl () {
module=$1
std_in=$2

erl -sname HackerRank@localhost -noshell -run $module main -run init stop <<< "$std_in"
}



for i in "${#inputs[@]}"
do
    out=$(run_erl $problem "$inputs[i]")
    if [[ "$outputs[i]" != "$out" ]]
       then 
           echo "bad results"
           echo ">>> in:"
           echo "$i"
           echo ">>> out: "
           echo "$out"
           exit 2
    fi
done

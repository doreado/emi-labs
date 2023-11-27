#!/usr/bin/env sh


cmd () {
    ./dpm_simulator -psm example/psm.txt -wl example/workload_1.txt -t $1 \
    | grep -i 'tot\.' \
    | cut  -f 7,13 -d ' '
}

for i in {0..10};
do
    cmd $i
    echo -e "\n"
done

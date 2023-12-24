#!/usr/bin/env sh

init=0

cmd () {
    echo -n "$2,"
    ./dpm_simulator -psm example/psm.txt -wl example/workload_$1.txt -t $2
}

if [ $# -lt 2 ]; then
    echo "Usage: ./run.sh workload_number max_timeout"
    echo "The script simulates the workload_number 0 and max_timeout"
    exit 1
fi;

echo -e "timeout,active,inactive,run_time,idle_time,sleep_time,timeout_waiting_time,total_time,transitions_number,transitions_time,transition_energy,total_energy\n"

for i in $(seq 0 "$3" "$2");
do
    cmd "$1" "$i"
done > result"$1"_"$2"_"$3".txt

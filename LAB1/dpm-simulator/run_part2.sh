#!/usr/bin/env sh


cmd () {
    echo -n "$2,"
    ./dpm_simulator -psm example/psm.txt -wl example/workload_$1.txt -t $2 -lp sleep
}

if [ $# -lt 2 ]; then
    printf "Usage: ./run.sh WORKLOAD_NUMBER MAX_TIMEOUT INCREMENT\n"
    printf "The script simulates the WORKLOAD_NUMBER with different timeouts between 0 and MAX_TIMEOUT in steps of INCREMENT"
    exit 1
fi;

file_name="results/part2_$1.txt"
printf "timeout,active,inactive,run_time,idle_time,sleep_time,timeout_waiting_time,total_time,total_time_no_dpm,transitions_number,transitions_time,transition_energy,total_energy,total_energy_no_dpm\n" > "$file_name"

for i in $(seq 0 "$3" "$2");
do
    cmd "$1" "$i"
done >> "$file_name"

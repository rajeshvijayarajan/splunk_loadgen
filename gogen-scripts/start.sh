#!/bin/bash
# Get flags
count=8
remove=false
directory=/tmp/generated_data
name=webserver
poll=false

while getopts c:r:d:n: flag; do
    case "${flag}" in
    # how many instances to run
    c) count=${OPTARG} ;;
    # remove directory after ending the script (useful for testing)
    r) remove=${OPTARG} ;;
    # name of the directory where the data is generated
    d) directory=${OPTARG} ;;
    # name of the file created by gogen. Will append numbers for each instance
    n) name=${OPTARG} ;;
        # Will poll to show the data generation speed
        # p) poll=${OPTARG} ;;
    esac
done
# echo $count
# echo $remove
# echo $directory
# echo $name

# Kill background hosts on exit
exit() {
    for p in "${pids[@]}"; do
        kill "$p"
    done
    if $remove; then
        rm -rf $directory*
    fi
}
#trap exit EXIT

# start gogen
pids=()
start_gogen() {
    
    for ((i = 1; i <= $count; i++)); do
        mkdir -p $directory/$i
        for ((j = 1; j <= 2; j++)); do
		gogen -c /home/hpadmin/gogen-scripts/every.custom.yml -o file -f ${directory}/$i/${name}_${j}.log &
        done
	pids+=($!)
    done
    sleep 1
    if $poll; then
        tail -f $directory/1/* | pv >/dev/null
        # pids+=($!)
        # fg % 1
    fi
}
start_gogen

# pids=()
# background job 1 &
# pids+=($!)
# background job 2... &
# pids+=($!)
# foreground job

# start polling for file size increase speed

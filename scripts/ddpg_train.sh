#!/usr/bin/env bash

function launch() {
	rm -r "$2"
	mkdir "$2"
	tmux new -d -s "$1"
	tmux send -t $1 "$3 > /dev/null &" C-m
	sleep 10
}

# 2020-06-16
values="000 001 002 003 004 005 006 007"
count=0
port_base=40000
gpu_start=0
gpu_count=2
for v in $values
do
	JOB=empty_goal_$v
	SAVE=~/projects/dqn-hfo/$JOB
	GPU=$(($gpu_start + $count % $gpu_count))
	PORT=$(($port_base + 3 * $count))
	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 0 --beta 0.2 --max_iter 3000000 --port $PORT"
	launch $JOB $SAVE "$PID"
	count=$(($count+1))
done




# test
# dqn -save test_empty_goal_padded/ddpg --noremove_old_snapshots --gpu_device 1 --pad 9 --offense_agents 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
# dqn -save test_defended_goal/ddpg --noremove_old_snapshots --gpu_device 1 --offense_agents 1 --defense_npcs 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
# dqn -save test_empty_goal/ddpg --noremove_old_snapshots --gpu_device 0 --offense_agents 1 --offense_on_ball 0 --beta 0.2 > /dev/null &

#!/usr/bin/env bash

# Evaluate command
# ./bin/dqn --evaluate --save results/empty_000 --actor_snapshot empty_goal_000/ddpg_agent0_actor_iter_3000000.solverstate --critic_snapshot empty_goal_000/ddpg_agent0_critic_iter_3000000.solverstate --memory_snapshot empty_goal_000/ddpg_agent0_iter_3000000.replaymemory --offense_agents 1

#./bin/dqn --evaluate --save results/defended_000 --actor_snapshot defended_goal_000/ddpg_agent0_actor_iter_1450000.solverstate --critic_snapshot empty_goal_000/ddpg_agent0_critic_iter_1450000.solverstate --memory_snapshot empty_goal_000/ddpg_agent0_iter_1450000.replaymemory --offense_agents 1 --defense_npcs 1

# ./bin/dqn --evaluate --save results/defended_000 --actor_snapshot defended_goal_000/ddpg_agent0_actor_iter_1000000.solverstate --critic_snapshot defended_goal_000/ddpg_agent0_critic_iter_1000000.solverstate --memory_snapshot defended_goal_000/ddpg_agent0_iter_1000000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --log_game --log-dir "logs/defended_000"

function launch() {
	rm -r "$2"
	mkdir "$2"
	tmux new -d -s "$1"
	tmux send -t $1 "$3 > /dev/null &" C-m
	sleep 10
}

# 2020-06-19
# Defended goal test, original feature set (59 values) and order, with offense on ball 
values="000 001"
count=0
port_base=40010
gpu_start=0
gpu_count=2
for v in $values
do
	JOB=test_defended_goal_on_ball_$v
	SAVE=~/projects/dqn-hfo/$JOB
	GPU=$(($gpu_start + $count % $gpu_count))
	PORT=$(($port_base + 3 * $count))
	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --max_iter 10000000 --port $PORT"
#	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_npcs 1 --beta 0.2 --max_iter 10000000 --port $PORT"
	launch $JOB $SAVE "$PID"
	count=$(($count+1))
done


# 2020-06-18
# Defended goal demo using original feature set (68 values) and order, with ball
# values="000 001"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=2
# for v in $values
# do
# 	JOB=defended_goal_$v
# 	SAVE=~/projects/dqn-hfo/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# #	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_npcs 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done


# 2020-06-16
# Empty goal demo using original feature set (59 values) and order, 8 agents
# values="000 001 002 003 004 005 006 007"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=2
# for v in $values
# do
# 	JOB=empty_goal_$v
# 	SAVE=~/projects/dqn-hfo/state_empty_goal_orignal_features/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 0 --beta 0.2 --max_iter 3000000 --port $PORT"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done




# test
# dqn -save test_empty_goal_padded/ddpg --noremove_old_snapshots --gpu_device 1 --pad 9 --offense_agents 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
# dqn -save test_defended_goal/ddpg --noremove_old_snapshots --gpu_device 1 --offense_agents 1 --defense_npcs 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
# dqn -save test_empty_goal/ddpg --noremove_old_snapshots --gpu_device 0 --offense_agents 1 --offense_on_ball 0 --beta 0.2 > /dev/null &

#!/usr/bin/env bash

# Evaluate command
# ./bin/dqn --evaluate --save results/empty_000 --actor_snapshot empty_goal_000/ddpg_agent0_actor_iter_3000000.solverstate --critic_snapshot empty_goal_000/ddpg_agent0_critic_iter_3000000.solverstate --memory_snapshot empty_goal_000/ddpg_agent0_iter_3000000.replaymemory --offense_agents 1

#./bin/dqn --evaluate --save results/defended_000 --actor_snapshot defended_goal_000/ddpg_agent0_actor_iter_1450000.solverstate --critic_snapshot empty_goal_000/ddpg_agent0_critic_iter_1450000.solverstate --memory_snapshot empty_goal_000/ddpg_agent0_iter_1450000.replaymemory --offense_agents 1 --defense_npcs 1

# ./bin/dqn --evaluate --save results/defended_000 --actor_snapshot defended_goal_000/ddpg_agent0_actor_iter_1000000.solverstate --critic_snapshot defended_goal_000/ddpg_agent0_critic_iter_1000000.solverstate --memory_snapshot defended_goal_000/ddpg_agent0_iter_1000000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --log_game --log-dir "logs/defended_000"

# ./bin/dqn --evaluate --save results/test_resequence_000 --actor_snapshot state/test/test_resequence_values_000/ddpg_agent0_actor_iter_10000.solverstate --critic_snapshot state/test/test_resequence_values_000/ddpg_agent0_critic_iter_10000.solverstate --memory_snapshot state/test/test_resequence_values_000/ddpg_agent0_iter_10000.replaymemory --offense_agents 1 --defense_npcs 1 --hfo_seed 123 --deterministic --log_game --record_dir log/test --port 50001 && mv log/test/base_left-11.log log/test/test_resequence_000.log && \
# ./bin/dqn --evaluate --save results/test_resequence_001 --actor_snapshot state/test/test_resequence_values_001/ddpg_agent0_actor_iter_10000.solverstate --critic_snapshot state/test/test_resequence_values_001/ddpg_agent0_critic_iter_10000.solverstate --memory_snapshot state/test/test_resequence_values_001/ddpg_agent0_iter_10000.replaymemory --offense_agents 1 --defense_npcs 1 --resequence_features --hfo_seed 123 --deterministic --log_game --record_dir log/test --port 50001 > /dev/null && mv log/test/base_left-11.log log/test/test_resequence_001.log && \
# ./bin/dqn --evaluate --save results/test_resequence_002 --actor_snapshot state/test/test_resequence_values_002/ddpg_agent0_actor_iter_10000.solverstate --critic_snapshot state/test/test_resequence_values_002/ddpg_agent0_critic_iter_10000.solverstate --memory_snapshot state/test/test_resequence_values_002/ddpg_agent0_iter_10000.replaymemory --offense_agents 1 --hfo_seed 123 --deterministic --log_game --record_dir log/test --port 50001 && mv log/test/base_left-11.log log/test/test_resequence_002.log && \
# ./bin/dqn --evaluate --save results/test_resequence_003 --actor_snapshot state/test/test_resequence_values_003/ddpg_agent0_actor_iter_10000.solverstate --critic_snapshot state/test/test_resequence_values_003/ddpg_agent0_critic_iter_10000.solverstate --memory_snapshot state/test/test_resequence_values_003/ddpg_agent0_iter_10000.replaymemory --offense_agents 1 --resequence_features --hfo_seed 123 --deterministic --log_game --record_dir log/test --port 50001 > /dev/null && mv log/test/base_left-11.log log/test/test_resequence_003.log

# evaluate and produce game replay
# agent=2 && phase=5 && score=1.000000 && snapshot=310367 && defense_dummies=0 && defense_npcs=0 && ball_params='' && ./bin/dqn --evaluate --save scratch/ --actor_weights state/ch2/agent$agent/phase$phase/ddpg_agent0_HiScore${score}_actor_iter_$snapshot.caffemodel --critic_weights state/ch2/agent$agent/phase$phase/ddpg_agent0_HiScore${score}_critic_iter_$snapshot.caffemodel --memory_snapshot state/ch2/agent$agent/phase$phase/ddpg_agent0_HiScore${score}_iter_$snapshot.replaymemory --offense_agents 1 --defense_dummies $defense_dummies --defense_npcs $defense_npcs $ball_params --port 55250 --record_dir scratch/ --log_game --log_dir scratch/ --repeat_games 10

# agent=2 && phase=5 && score=1.000000 && snapshot=310367 && defense_dummies=0 && defense_npcs=0 && ball_params='' && ./bin/dqn --evaluate --save scratch/ --actor_snapshot state/ch2/agent$agent/phase$phase/ddpg_agent0_HiScore${score}_actor_iter_$snapshot.solverstate --critic_snapshot state/ch2/agent$agent/phase$phase/ddpg_agent0_HiScore${score}_critic_iter_$snapshot.solverstate --memory_snapshot state/ch2/agent$agent/phase$phase/ddpg_agent0_HiScore${score}_iter_$snapshot.replaymemory --offense_agents 1 --defense_dummies $defense_dummies --defense_npcs $defense_npcs $ball_params --port 55250 --record_dir scratch/ --log_game --log_dir scratch/ --repeat_games 10


function launch() {
	rm -r "$2"
	mkdir -p "$2"
	tmux new -d -s "$1"
	tmux send -t $1 "$3" C-m
	echo $1 $2 "$3"
	sleep 5
}


# # 2020-09-13
function resume() {
	port_base=40000
	gpu_start=0
	gpu_count=8

	category=$1
	value=$2
	base=$3
	group=$4
	count=$5
	iter=$6
	source=$7
	rate=$8

	JOB=${category}_${value}
	SAVE=${base}${group}${category}/${JOB}
	GPU=$(($gpu_start + $count % $gpu_count))
	PORT=$(($port_base + 3 * $count))
	CMD="~/projects/dqn-hfo/bin/dqn"
	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --beta 0.2 --max_iter 10000000 --port $PORT"
	ACTOR="--actor_weights state/ch3/${source}/frozen_layer_learning_${value}/ddpg_agent0_HiScore${rate}_actor_iter_${iter}.caffemodel"
	CRITIC="--critic_weights state/ch3/${source}/frozen_layer_learning_${value}/ddpg_agent0_HiScore${rate}_critic_iter_${iter}.caffemodel"
	MEMORY="--memory_snapshot state/ch3/${source}/frozen_layer_learning_${value}/ddpg_agent0_HiScore${rate}_iter_${iter}.replaymemory"
	PID="$CMD $OPTIONS $ACTOR $CRITIC $MEMORY"
	ls $SAVE
	ls state/ch3/${source}/frozen_layer_learning_${value}/ddpg_agent0_HiScore${rate}_actor_iter_${iter}.caffemodel
	lsof -i :$(($port_base + 3 * $count))-$(($port_base + 3 * $count + 2))
	launch $JOB $SAVE "$PID"
}

# ~/projects/dqn-hfo/bin/dqn --save /home/blair/projects/dqn-hfo/state/ch3/unfrozen_learning_no_explore/unfrozen_learning_no_explore_000_3M/ddpg --gpu_device 1 --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --beta 0.2 --max_iter 10000000 --port 40099 --actor_weights state/ch3/frozen_layer_learning/frozen_layer_learning_000_3M/ddpg_agent0_HiScore0.010000_actor_iter_90188.caffemodel --critic_weights state/ch3/frozen_layer_learning/frozen_layer_learning_000_3M/ddpg_agent0_HiScore0.010000_critic_iter_90188.caffemodel --memory_snapshot state/ch3/frozen_layer_learning/frozen_layer_learning_000_3M/ddpg_agent0_HiScore0.010000_iter_90188.replaymemory

base="/home/blair/projects/dqn-hfo/state/"
group="ch3/"
count=110 # use 15 for 006

value="006_1M"

source="frozen_layer_learning"
# category="unfrozen_learning_no_2x_explore"
category="unfrozen_learning_no_explore"
iter="230326"
rate="0.010000"
resume $category $value $base $group $count $iter $source $rate


# value="000_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="3487879"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="350624"
# rate="0.020000"
# resume $category $value $base $group $count $iter $source $rate

# value="001_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="200446"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="410725"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# value="002_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="340662"
# rate="0.020000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="3025608"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# value="003_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="1412629"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="3978204"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# value="004_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="40099"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="4046919"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# value="005_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="1663395"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="3896718"
# rate="0.020000"
# resume $category $value $base $group $count $iter $source $rate

# value="006_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter=""
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter=""
# rate="0.020000"
# resume $category $value $base $group $count $iter $source $rate

# source="006_5M"

# category="unfrozen_learning_explore"
# iter="3606166"

# value="007_5M"

# source="frozen_layer_learning"
# category="unfrozen_learning_no_explore"
# iter="30034"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# count=$(($count+1))
# source="frozen_layer_learning_explore_10000"
# category="unfrozen_learning_explore"
# iter="4848140"
# rate="0.010000"
# resume $category $value $base $group $count $iter $source $rate

# source="007_5M"

# category="unfrozen_learning_no_explore"
# iter="30034"

# category="unfrozen_learning_explore"
# iter="4848140"


# value=${source}_1M
# iter="981605"
# resume $category $value $base $group $count $iter $source $rate

# 2020-09-07
# Test unfrozen learning
# source="002_1M"
# iter="2051536"
# values=${source}_${iter}
# rate="0.010000"
# base="/home/blair/projects/dqn-hfo/state/"
# group="test/"
# category="test_unfrozen_learning"
# count=34
# port_base=40300
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --explore 0 --exclude_status_flag --resequence_features --beta 0.2 --max_iter 5000000 --port $PORT"
# 	ACTOR="--actor_weights state/ch3/frozen_layer_learning/frozen_layer_learning_${source}/ddpg_agent0_HiScore${rate}_actor_iter_${iter}.caffemodel"
# 	CRITIC="--critic_weights state/ch3/frozen_layer_learning/frozen_layer_learning_${source}/ddpg_agent0_HiScore${rate}_critic_iter_${iter}.caffemodel"
# 	MEMORY="--memory_snapshot state/ch3/frozen_layer_learning/frozen_layer_learning_${source}/ddpg_agent0_HiScore${rate}_iter_${iter}.replaymemory"
# 	PID="$CMD $OPTIONS $ACTOR $CRITIC $MEMORY"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done



# # 2020-08-22
# # Defended goal demo without status flag (58 values) and resequenced order

# function resume() {
# 	port_base=40000
# 	gpu_start=0
# 	gpu_count=8

# 	category=$1
# 	value=$2
# 	base=$3
# 	group=$4
# 	count=$5
# 	iter=$6
# 	source=$7

# 	JOB=${category}_${value}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --explore 0 --freeze_inner_layers --transfer_weights --exclude_status_flag --resequence_features --beta 0.2 --max_iter 5000000 --port $PORT"
# 	ACTOR="--actor_weights state/baseline/baseline_empty_resequenced_wo_status/baseline_empty_resequenced_wo_status_${source}/ddpg_agent0_HiScore1.000000_actor_iter_${iter}.caffemodel"
# 	CRITIC="--critic_weights state/baseline/baseline_empty_resequenced_wo_status/baseline_empty_resequenced_wo_status_${source}/ddpg_agent0_HiScore1.000000_critic_iter_${iter}.caffemodel"
# 	PID="$CMD $OPTIONS $ACTOR $CRITIC"
# 	launch $JOB $SAVE "$PID"
# }

# base="/home/blair/projects/dqn-hfo/state/"
# group="ch3/"
# category="frozen_layer_learning"
# count=2

# source="000"

# value=${source}_1M
# iter="981605"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1921984"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2982430"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3990148"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990169"
# resume $category $value $base $group $count $iter $source


# source="001"

# count=$(($count+1))
# value=${source}_1M
# iter="980297"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1990703"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2990073"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3990483"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990849"
# resume $category $value $base $group $count $iter $source


# source="002"

# count=$(($count+1))
# value=${source}_1M
# iter="991367"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1990350"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2990946"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3990067"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990283"
# resume $category $value $base $group $count $iter $source


# source="003"

# count=$(($count+1))
# value=${source}_1M
# iter="991324"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1991856"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2992583"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3962980"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4983333"
# resume $category $value $base $group $count $iter $source 


# source="004"

# count=$(($count+1))
# value=${source}_1M
# iter="971313"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1991881"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2992483"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3980256"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990053"
# resume $category $value $base $group $count $iter $source


# source="005"

# count=$(($count+1))
# value=${source}_1M
# iter="970751"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1980288"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2990024"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3980030"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990038"
# resume $category $value $base $group $count $iter $source    


# source="006"

# count=$(($count+1))
# value=${source}_1M
# iter="971158"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1990111"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2980453"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3990241"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990078"
# resume $category $value $base $group $count $iter $source 


# source="007"

# count=$(($count+1))
# value=${source}_1M
# iter="990634"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_2M
# iter="1970221"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_3M
# iter="2990879"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_4M
# iter="3991265"
# resume $category $value $base $group $count $iter $source

# count=$(($count+1))
# value=${source}_5M
# iter="4990068"
# resume $category $value $base $group $count $iter $source 
    
        

# ./bin/dqn --save state/ch2/agent1/phase2/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase1/ddpg_agent0_HiScore1.000000_actor_iter_70130.caffemodel --critic_weights state/ch2/agent1/phase1/ddpg_agent0_HiScore1.000000_critic_iter_70130.caffemodel --memory_snapshot state/ch2/agent1/phase1/ddpg_agent0_HiScore1.000000_iter_70130.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024

# Best perfect score per million training cycles
# baseline_empty_resequenced_wo_status
#     1000000 2000000 3000000 4000000 5000000 #
# 000  981605 1921984 2982430 3990148 4990169 #
# 001  980297 1990703 2990073 3990483 4990849 #
# 002  991367 1990350 2990946 3990067 4990283 # bak: first 1.0 4751394
# 003  991324 1991856 2992583 3962980 4983333 #
# 004  971313 1991881 2992483 3980256 4990053 #
# 005  970751 1980288 2990024 3980030 4990038 #
# 006  971158 1990111 2980453 3990241 4990078 #
# 007  990634 1970221 2990879 3991265 4990068 #
# baseline_empty_resequenced_wo_status_padded_random
# 000  991218 1980325 2990252 3990229 4990554 # bak: first 1.0 1653509
# 001  990758 1990216 2990265 3980172 4990130 #
# 002  981403 1930224 2990681 3991107 4990329 #
# 003  991679 1992104 2982615 3993078 4983522 #
# 004  951753 1990135 2980439 3970994 4991437 #
# 005  991040 1991470 2991852 3992299 4992751 #
# 006  990969 1991424 2982203 3990400 4990279 #
# 007  990944 1970193 2990263 3990704 4980208 #
# baseline_empty_resequenced_wo_status_padded_zeros
# 000  971684 1992123 2990277 3990337 4990775 #
# 001  991093 1990046 2990012 3990387 4990820 #	bak: first 1.0 5752284
# 002  991717 1992212 2982789 3990163 4970594 #
# 003  990003 1970129 2990250 3980366 4990298 # bak: first 1.0 2194912
# 004  961102 1970001 2980069 3990078 4990527 #
# 005  990864 1991268 2980351 3990119 4990484 #
# 006  991201 1951534 2980411 3970870 4990047 # bak: first 1.0 1182253
# 007  990654 1991016 2991384 3992477 4992798 #

# # 2020-08-22
# # Defended goal demo without status flag (58 values) and resequenced order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="test/"
# category="test_frozen_layers"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --beta 0.2 --max_iter 1000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-08-17
# # Defended goal demo without status flag (58 values) and resequenced order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_resequenced_wo_status_padded_random"
# count=0
# port_base=40048
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --pad 9 --beta 0.2 --max_iter 5000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-08-17
# # Defended goal demo without status flag (58 values) and resequenced order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_resequenced_wo_status_padded_zeros"
# count=0
# port_base=40024
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --pad 9 --pad_zero --beta 0.2 --max_iter 5000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-08-16
# # Defended goal demo without status flag (58 values) and resequenced order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_resequenced_wo_status"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --beta 0.2 --max_iter 5000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-08-11
# # Defended goal demo without status flag (58 values) and resequenced order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_resequenced_wo_status"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --exclude_status_flag --resequence_features --beta 0.2 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# 2020-08-04
# Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_original_wo_status_100_reward_1_beta"
# count=0
# port_base=40096
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goal_reward 100.0 --exclude_status_flag --beta 1.0 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-08-04
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_original_wo_status_100_reward_0_beta"
# count=0
# port_base=40072
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goal_reward 100.0 --exclude_status_flag --beta 0.0 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done


# 2020-08-02
# Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_original_wo_status_100_reward"
# count=0
# port_base=40048
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goal_reward 100.0 --exclude_status_flag --beta 0.2 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# 2020-07-29
# Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_original_wo_status"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --exclude_status_flag --beta 0.2 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-29
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_original_w_status"
# count=0
# port_base=40024
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# Scratch pad
#--team_name test_001 --log_game --record_dir log/test --log_dir log/test 
# mv log/test/$JOB/base_left-11.log log/test/$JOB.log && 
 # && rm -r log/test/$JOB
# && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl

# 2020-07-23
# Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_100_reward"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --resequence_features --goal_reward 100.0 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-23
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended_5_reward"
# count=0
# port_base=40024
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --resequence_features --beta 0.2 --max_iter 10000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-16
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_68_resequenced_on_ball_random"
# count=0
# port_base=40100
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --pad 9 --resequence_features --beta 0.2 --max_iter 3000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-17
# # Test frozen layers
# values="000"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_test_frozen"
# count=0
# port_base=40064
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --resequence_features --beta 0.2 --max_iter 8000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-16
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_defended"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --resequence_features --beta 0.2 --max_iter 8000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-16
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_59_resequenced_on_ball"
# count=0
# port_base=40032
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --resequence_features --beta 0.2 --max_iter 3000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# # 2020-07-12
# # Empty goal demo using original feature set (59 values) and order
# values="000 001 002 003 004 005 006 007"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_59_resequenced_no_ball"
# count=0
# port_base=40032
# gpu_start=0
# gpu_count=8
# for v in $values
# do
# 	JOB=${category}_${v}
# 	SAVE=${base}${group}${category}/${JOB}
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 0 --resequence_features --beta 0.2 --max_iter 3000000 --port $PORT"
# 	PID="$CMD $OPTIONS"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# evaluate performance of random007 when applied to defended goal
# values="561470 571477 581490 711614 721615 731615 751627 771634 801641 821654 841666 851666 921688 941696 991728 1031746"
# values+="2443024 2493062 2573109 2583114 2633140 2653146 2683157 2703167 2743184 2773218 2783222 2813235 2903286 2913291 2923298 2953311"
# values="2743184 2773218 2783222 2813235 2903286 2913291 2923298 2953311"
# base="/home/blair/projects/dqn-hfo/state/"
# group="baseline/"
# category="baseline_empty_68_random/"
# exp="baseline_empty_68_random_007/"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# num_agents=1
# num_npcs=1

# for v in $values
# do
# 	JOB=baseline_empty_68_random_007_${v}
# 	SAVE=${base}baseline_eval/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	CMD="~/projects/dqn-hfo/bin/dqn"
# 	OPTIONS="--save ${SAVE}/ddpg --gpu_device ${GPU} --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --resequence_features --beta 0.2 --max_iter 8000000 --port $PORT"
# 	ACTOR="--actor_weights ${base}${group}${category}${exp}ddpg_agent0_HiScore1.000000_actor_iter_${v}.caffemodel"
# 	CRITIC="--critic_weights ${base}${group}${category}${exp}ddpg_agent0_HiScore1.000000_critic_iter_${v}.caffemodel"
# 	MEMORY="--memory_snapshot ${base}${group}${category}${exp}ddpg_agent0_HiScore1.000000_iter_${v}.replaymemory"
# 	PID="$CMD $OPTIONS $ACTOR $CRITIC $MEMORY"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))	
# done


# 8 agents to 3,000,000 iterations with 59 state features random ball and player location against empty goal
# 8 agents to 3,000,000 iterations with 68 state features (9-zero padded) with random ball and player location against empty goal
# 8 agents to 3,000,000 iterations with 68 state features (9-random padded) with random ball and player location against empty goal
# 2020-06-22
# values="000 001 002 003 004 005 006 007"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=8
# num_agents=1

# for v in $values
# do
# 	JOB=baseline_empty_59_$v
# 	SAVE=~/projects/dqn-hfo/state/baseline/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --resequence_features --beta 0.2 --max_iter 3000000 --port $PORT"
# 	mkdir -p $SAVE
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# for v in $values
# do
# 	JOB=baseline_empty_68_zeroes_$v
# 	SAVE=~/projects/dqn-hfo/state/baseline/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --resequence_features --pad 9 --pad_zero --beta 0.2 --max_iter 3000000 --port $PORT"
# 	mkdir -p $SAVE
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# for v in $values
# do
# 	JOB=baseline_empty_68_random_$v
# 	SAVE=~/projects/dqn-hfo/state/baseline/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --resequence_features --pad 9 --beta 0.2 --max_iter 3000000 --port $PORT"
# 	mkdir -p $SAVE
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# for v in $values
# do
# 	JOB=defended_goal_$v
# 	SAVE=~/projects/dqn-hfo/state/baseline/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	mkdir -p $SAVE
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# for v in $values
# do
# 	JOB=defended_goal_resequenced_$v
# 	SAVE=~/projects/dqn-hfo/state/baseline/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --resequence_features --beta 0.2 --max_iter 10000000 --port $PORT"
# 	mkdir -p $SAVE
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# 2020-06-22
# Resume Defended Goal Test after fault
# values="000 001"
# count=0
# port_base=40000
# gpu_start=0
# gpu_count=2
# num_agents=2
# for v in $values
# do
# 	JOB=defended_goal_$v
# 	SAVE=~/projects/dqn-hfo/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --explore 0 --max_iter 10000000 --port $PORT"
# #	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_npcs 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# values="000 001"
# count=0
# port_base=40010
# gpu_start=0
# gpu_count=2
# num_agents=2
# for v in $values
# do
# 	JOB=test_defended_goal_on_ball_$v
# 	SAVE=~/projects/dqn-hfo/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --explore 0 --max_iter 10000000 --port $PORT"
# #	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_npcs 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# 2020-06-22
# explore player positioning
# values="000 001 002 003"
# count=0
# port_base=40030
# gpu_start=0
# gpu_count=2
# num_agents=2
# for v in $values
# do
# 	JOB=test_player_position_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 2 --player_bounding_boxes '0.0,0.25,-0.25,0.25,0.5,0.75,-0.25,0.25' --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# 2020-06-22
# verify ball position features
# values="000"
# count=0
# port_base=40030
# gpu_start=0
# gpu_count=2
# num_agents=2
# for v in $values
# do
# 	JOB=test_ball_position_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --hfo_seed 123 --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# values="001"
# port_base=40035
# num_agents=2
# for v in $values
# do
# 	JOB=test_ball_position_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --beyond_kickable --offense_ball_dist 0.1 --hfo_seed 123 --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# values="002"
# port_base=40040
# num_agents=1
# for v in $values
# do
# 	JOB=test_ball_position_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --offense_on_ball 1 --beyond_kickable --offense_ball_dist 5.0 --hfo_seed 123 --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done


# 2020-06-20
# verify resequence features
# values="000"
# count=0
# port_base=40030
# gpu_start=0
# gpu_count=2
# num_agents=2
# for v in $values
# do
# 	JOB=test_resequence_values_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --hfo_seed 123 --deterministic --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# values="001"
# port_base=40035
# num_agents=2
# for v in $values
# do
# 	JOB=test_resequence_values_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --resequence_features --hfo_seed 123 --deterministic --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# values="002"
# port_base=40040
# num_agents=1
# for v in $values
# do
# 	JOB=test_resequence_values_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --hfo_seed 123 --deterministic --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# values="003"
# port_base=40045
# num_agents=1
# for v in $values
# do
# 	JOB=test_resequence_values_$v
# 	SAVE=~/projects/dqn-hfo/state/test/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + ($num_agents + 1) * $count))
# 	PID="mkdir log/test/$JOB && ~/projects/dqn-hfo/bin/dqn --evaluate --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --resequence_features --hfo_seed 123 --deterministic --log_game --game_log_dir log/test/$JOB --record_dir log/test/$JOB --port $PORT && mv log/test/$JOB/base_left-11.log log/test/$JOB.log && mv log/test/$JOB/*.rcg log/test/$JOB.rcg && mv log/test/$JOB/*.rcl log/test/$JOB.rcl && rm -r log/test/$JOB"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done

# 2020-06-19
# Defended goal test, original feature set (59 values) and order, with offense on ball 
# values="000 001"
# count=0
# port_base=40010
# gpu_start=0
# gpu_count=2
# for v in $values
# do
# 	JOB=test_defended_goal_on_ball_$v
# 	SAVE=~/projects/dqn-hfo/$JOB
# 	GPU=$(($gpu_start + $count % $gpu_count))
# 	PORT=$(($port_base + 3 * $count))
# 	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# #	PID="~/projects/dqn-hfo/bin/dqn --save $SAVE/ddpg --gpu_device $GPU --noremove_old_snapshots --offense_npcs 1 --beta 0.2 --max_iter 10000000 --port $PORT"
# 	launch $JOB $SAVE "$PID"
# 	count=$(($count+1))
# done


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


# # 2020-06-16
# # Empty goal demo using original feature set (59 values) and order
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

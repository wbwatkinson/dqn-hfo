#!/usr/bin/env bash

count=0

# folders="baseline_empty_59_000 baseline_empty_59_001 baseline_empty_59_002 baseline_empty_59_003 baseline_empty_59_004 baseline_empty_59_005 baseline_empty_59_006 baseline_empty_59_007 "
# folders="baseline_empty_68_zeroes_000 baseline_empty_68_zeroes_001 baseline_empty_68_zeroes_002 baseline_empty_68_zeroes_003 baseline_empty_68_zeroes_004 baseline_empty_68_zeroes_005 baseline_empty_68_zeroes_006 baseline_empty_68_zeroes_007 "
# folders+="baseline_empty_68_random_000 baseline_empty_68_random_001 baseline_empty_68_random_002 baseline_empty_68_random_003 baseline_empty_68_random_004 baseline_empty_68_random_005 baseline_empty_68_random_006 baseline_empty_68_random_007 "
# folders="agent1/phase6 agent2/phase6 agent3/phase6 agent4/phase6 agent5/phase8 agent6/phase8 agent7/phase8 agent8/phase5"
# folders="baseline_eval/baseline_empty_68_random_007"
# folders="2743184 2773218 2783222 2813235 2903286 2913291 2923298 2953311"

folders=""
# exp1="baseline_eval/baseline_empty_68_random_007"
# folders="${exp1}_2743184 ${exp1}_2773218 ${exp1}_2783222 ${exp1}_2813235 ${exp1}_2903286 ${exp1}_2913291 ${exp1}_2923298 ${exp1}_2953311 "
# exp2="ch2/agent"
# exp3="/phase11"
# folders+="${exp2}5${exp3} ${exp2}6${exp3} ${exp2}7${exp3} ${exp2}8${exp3} "
# exp31="/phase10"
# folders+="${exp2}9${exp31} "
# exp32="/phase11"
# folders+="${exp2}10${exp32} "
# exp4="baseline/baseline_defended_original_w_status/baseline_defended_original_w_status"
# folders+="${exp4}_000 ${exp4}_001 ${exp4}_002 ${exp4}_003 ${exp4}_004 ${exp4}_005 ${exp4}_006 ${exp4}_007 "
# exp4="baseline/baseline_defended_original_wo_status/baseline_defended_original_wo_status"
# folders+="${exp4}_000 ${exp4}_001 ${exp4}_002 ${exp4}_003 ${exp4}_004 ${exp4}_005 ${exp4}_006 ${exp4}_007 "
# exp4="baseline/baseline_defended_original_wo_status_100_reward/baseline_defended_original_wo_status_100_reward"
# folders+="${exp4}_000 ${exp4}_001 ${exp4}_002 ${exp4}_003 ${exp4}_004 ${exp4}_005 ${exp4}_006 ${exp4}_007 "
# exp4="baseline/baseline_defended_original_wo_status_100_reward_0_beta/baseline_defended_original_wo_status_100_reward_0_beta"
# folders+="${exp4}_000 ${exp4}_001 ${exp4}_002 ${exp4}_003 ${exp4}_004 ${exp4}_005 ${exp4}_006 ${exp4}_007 "
# exp4="baseline/baseline_defended_original_wo_status_100_reward_1_beta/baseline_defended_original_wo_status_100_reward_1_beta"
# folders+="${exp4}_000 ${exp4}_001 ${exp4}_002 ${exp4}_003 ${exp4}_004 ${exp4}_005 ${exp4}_006 ${exp4}_007 "

# exp="ch3/frozen_layer_learning/frozen_layer_learning"
# folders+="${exp}_006_5M "
# exp="ch3/frozen_layer_learning_explore_10000/frozen_layer_learning"
# folders+="${exp}_001_2M ${exp}_005_3M "

# folders+="0 "

# exp="ch3/unfrozen_learning_explore/unfrozen_learning_explore"
# group="5M"
# folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

# exp="ch3/unfrozen_learning_no_explore/unfrozen_learning_no_explore"
# folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_explore/unfrozen_learning_no_explore"
group="4M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_explore/unfrozen_learning_no_explore"
group="3M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_explore/unfrozen_learning_no_explore"
group="2M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_explore/unfrozen_learning_no_explore"
group="1M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

# exp="ch3/unfrozen_learning_no_2x_explore/unfrozen_learning_no_2x_explore"
# group="5M"
# folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_2x_explore/unfrozen_learning_no_2x_explore"
group="4M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_2x_explore/unfrozen_learning_no_2x_explore"
group="3M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_2x_explore/unfrozen_learning_no_2x_explore"
group="2M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

exp="ch3/unfrozen_learning_no_2x_explore/unfrozen_learning_no_2x_explore"
group="1M"
folders+="${exp}_000_${group} ${exp}_001_${group} ${exp}_002_${group} ${exp}_003_${group} ${exp}_004_${group} ${exp}_005_${group} ${exp}_006_${group} ${exp}_007_${group} "

# folders+="${exp4}_000_1M ${exp4}_000_2M ${exp4}_000_3M ${exp4}_000_4M ${exp4}_000_5M "

# folders+="${exp4}_001_1M ${exp4}_001_2M ${exp4}_001_3M ${exp4}_001_4M ${exp4}_001_5M "

# folders+="${exp4}_002_1M ${exp4}_002_2M ${exp4}_002_3M ${exp4}_002_4M ${exp4}_002_5M "

# folders+="${exp4}_003_1M ${exp4}_003_2M ${exp4}_003_3M ${exp4}_003_4M ${exp4}_003_5M "

# folders+="${exp4}_004_1M ${exp4}_004_2M ${exp4}_004_3M ${exp4}_004_4M ${exp4}_004_5M "

# folders+="${exp4}_005_1M ${exp4}_005_2M ${exp4}_005_3M ${exp4}_005_4M ${exp4}_005_5M "

# folders+="${exp4}_006_1M ${exp4}_006_2M ${exp4}_006_3M ${exp4}_006_4M ${exp4}_006_5M "

# folders+="${exp4}_007_1M ${exp4}_007_2M ${exp4}_007_3M ${exp4}_007_4M ${exp4}_007_5M "

# folders+="test/test_unfrozen_learning/test_unfrozen_learning_000_2M_20012 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_000_3M_90188 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_001_3M_100179 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_001_5M_200446 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_003_1M_210116 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_004_1M_190336 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_004_2M_60091 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_004_3M_230390 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_004_5M_40099 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_005_3M_10010 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_006_1M_230326 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_006_3M_40050 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_006_4M_30033 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_007_1M_220483 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_007_4M_130185 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_007_5M_30034 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_000_1M_320503 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_005_1M_1021895 "
# folders+="test/test_unfrozen_learning/test_unfrozen_learning_006_2M_1151286 "


# exp5="baseline/baseline_defended_5_reward/baseline_defended_5_reward"
# folders+="${exp5}_000 ${exp5}_001 ${exp5}_002 ${exp5}_003 ${exp5}_004 ${exp5}_005 ${exp5}_006 ${exp5}_007 "


# folders+="defended_goal_000 defended_goal_001 defended_goal_002 defended_goal_003 defended_goal_004 defended_goal_005 defended_goal_006 defended_goal_007 "
# folders+="defended_goal_resequenced_000 defended_goal_resequenced_001 defended_goal_resequenced_002 defended_goal_resequenced_003 defended_goal_resequenced_004 defended_goal_resequenced_005 defended_goal_resequenced_006 defended_goal_resequenced_007"

for f in ${folders}
do
	f="state/${f}/"
	# f="state/${f}/"

	# f="state/baseline/$f/"
	last_file=$(ls -v $f*HiScore* 2> /dev/null | tail -1 )
	file_count=$(ls -1v $f*HiScore* 2> /dev/null | wc -l )
	echo $last_file $((file_count / 5))
	count=$(($count+1))
done

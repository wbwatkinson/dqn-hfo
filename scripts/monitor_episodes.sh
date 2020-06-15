#!/usr/bin/env bash

folders="test_empty_goal_padded/ddpg test_defended_goal/ddpg test_empty_goal/ddpg"

for f in ${folders}
do
	f+="/dqn.INFO"
	header="==> ${f} <=="
	detail=$(grep 'Episode' $f | tail -1)
	echo $header $detail
	#grep 'Evaluation' $f | tail -1 | sed -r 's|(.*actor_iter = [0-9]*,)(.*)(goal_perc = *.)|\1 \3|';
done

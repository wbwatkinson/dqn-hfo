#!/usr/bin/env bash

folders="test_empty_goal_padded test_defended_goal test_empty_goal"

for f in ${folders}
do
	f+="/dqn.INFO"
	header="===> ${f} <==="
	detail=$(grep 'Evaluation' $f | tail -1 | sed -r 's|(.*actor_iter = [0-9]*,)(.*)(goal_perc = *.)|\1 \3|')
	echo $header $detail
done
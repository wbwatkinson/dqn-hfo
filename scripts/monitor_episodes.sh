#!/usr/bin/env bash

folders="empty_goal_000 empty_goal_001 empty_goal_002 empty_goal_003 empty_goal_004 empty_goal_005 empty_goal_006 empty_goal_007 defended_goal_000"

for f in ${folders}
do
	f="${f}/dqn.INFO"
	# f+="/dqn.INFO"
	header="==> ${f} <=="
	detail=$(grep 'Episode' $f | tail -1)
	echo $header $detail
	#grep 'Evaluation' $f | tail -1 | sed -r 's|(.*actor_iter = [0-9]*,)(.*)(goal_perc = *.)|\1 \3|';
done

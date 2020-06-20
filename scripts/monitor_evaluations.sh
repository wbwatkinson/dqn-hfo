#!/usr/bin/env bash

folders="empty_goal_000 empty_goal_001 empty_goal_002 empty_goal_003 empty_goal_004 empty_goal_005 empty_goal_006 empty_goal_007 defended_goal_000 defended_goal_001 test_defended_goal_on_ball_000 test_defended_goal_on_ball_001"

for f in ${folders}
do
	f+="/dqn.INFO"
	header="===> ${f} <==="
	detail=$(grep 'Evaluation' $f | tail -1 | sed -r 's|(.*actor_iter = [0-9]*,)(.*)(goal_perc = *.)|\1 \3|')
	echo $header $detail
done

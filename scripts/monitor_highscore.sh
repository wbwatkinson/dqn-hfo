#!/usr/bin/env bash

count=0

folders="empty_goal_000 empty_goal_001 empty_goal_002 empty_goal_003 empty_goal_004 empty_goal_005 empty_goal_006 empty_goal_007"

for f in ${folders}
do
	f+="/"
	last_file=$(ls -v $f*HiScore* 2> /dev/null | tail -1 )
	file_count=$(ls -1v $f*HiScore* 2> /dev/null | wc -l )
	echo $f $last_file $((file_count / 5))
	count=$(($count+1))
done
#!/usr/bin/env bash

count=0

folders="test_empty_goal_padded test_defended_goal test_empty_goal"

for f in ${folders}
do
	f+="/"
	last_file=$(ls -v $f*HiScore* 2> /dev/null | tail -1 )
	file_count=$(ls -1v $f*HiScore* 2> /dev/null | wc -l )
	echo $f $last_file $((file_count / 5))
	count=$(($count+1))
done
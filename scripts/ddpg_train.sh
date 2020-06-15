


# test
dqn -save test_empty_goal_padded/ddpg --noremove_old_snapshots --gpu_device 1 --pad 9 --offense_agents 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
dqn -save test_defended_goal/ddpg --noremove_old_snapshots --gpu_device 1 --offense_agents 1 --defense_npcs 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
dqn -save test_empty_goal/ddpg --noremove_old_snapshots --gpu_device 0 --offense_agents 1 --offense_on_ball 0 --beta 0.2 > /dev/null &
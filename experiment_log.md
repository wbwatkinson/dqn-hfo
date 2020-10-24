

## Baseline



## Chapter 2 Experiments

Chapter considers the viability of using transfer learning in complex, dynamic systems, and compares the approach to an engineered, or shaped reward signal.



### First Learning Phase: initialize all agents with first learning phase

#### Overview

- First learning phase involves agents standing directly in front of goal with the ball. Object is to learn to kick the ball into the goal.
-- Agents 1-4 attempt to score against an empty goal
-- Agents 5-8 attempt to score against a defended goal

#### Execution Commands

These commands can be run in a tmux session or nohup

```bash
./bin/dqn --save state/ch2/agent1/phase1/ddpg --gpu_device 0 --offense_agents 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52000
./bin/dqn --save state/ch2/agent2/phase1/ddpg --gpu_device 1 --offense_agents 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52003  
./bin/dqn --save state/ch2/agent3/phase1/ddpg --gpu_device 2 --offense_agents 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52006  
./bin/dqn --save state/ch2/agent4/phase1/ddpg --gpu_device 3 --offense_agents 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52009 
./bin/dqn --save state/ch2/agent5/phase1/ddpg --gpu_device 4 --offense_agents 1 --defense_dummies 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52012
./bin/dqn --save state/ch2/agent6/phase1/ddpg --gpu_device 5 --offense_agents 1 --defense_dummies 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52015
./bin/dqn --save state/ch2/agent7/phase1/ddpg --gpu_device 6 --offense_agents 1 --defense_dummies 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52018
./bin/dqn --save state/ch2/agent8/phase1/ddpg --gpu_device 7 --offense_agents 1 --defense_dummies 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52021 
./bin/dqn --save state/ch2/agent9/phase1/ddpg --gpu_device 0 --offense_agents 1 --defense_dummies 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase1/ddpg --gpu_device 1 --offense_agents 1 --defense_dummies 1 --ball_x_min=0.97 --ball_x_max=0.97 --ball_y_min=-0.2 --ball_y_max=0.2 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027 
```

#### Transfer Points

| Agent  | Snapshot                    | Iterations | Total Iterations  |
|--------|-----------------------------|-----------:|------------------:|
| Agent1 | HiScore1.000000_iter_70130  | 70,310     | 70,310			|
| Agent2 | HiScore1.000000_iter_60143  | 60,143     | 60,143			|
| Agent3 | HiScore1.000000_iter_481189 | 481,189    | 500,000			|
| Agent4 | HiScore1.000000_iter_481173 | 481,173    | 500,000			|
| Agent5 | HiScore1.000000_iter_50137  | 50,137     | 50,137			|
| Agent6 | HiScore1.000000_iter_60124  | 60,124     | 60,124			|
| Agent7 | HiScore1.000000_iter_481272 | 500,000    | 500,000			|
| Agent8 | HiScore1.000000_iter_481144 | 500,000    | 500,000			|




### Second Learning Phase

#### Overview

- Second learning phase involves agents standing near the foul line with the ball. Objective is to learn to kick the ball into the goal.
-- Agents 1-4 attempt to score against an empty goal
-- Agents 5-8 attempt to score against a defended goal

#### Execution Commands

These commands can be run in a tmux session or nohup

```bash
./bin/dqn --save state/ch2/agent1/phase2/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase1/ddpg_agent0_HiScore1.000000_actor_iter_70130.caffemodel --critic_weights state/ch2/agent1/phase1/ddpg_agent0_HiScore1.000000_critic_iter_70130.caffemodel --memory_snapshot state/ch2/agent1/phase1/ddpg_agent0_HiScore1.000000_iter_70130.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent2/phase2/ddpg --gpu_device 1 --actor_weights state/ch2/agent2/phase1/ddpg_agent0_HiScore1.000000_actor_iter_60143.caffemodel --critic_weights state/ch2/agent2/phase1/ddpg_agent0_HiScore1.000000_critic_iter_60143.caffemodel --memory_snapshot state/ch2/agent2/phase1/ddpg_agent0_HiScore1.000000_iter_60143.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
./bin/dqn --save state/ch2/agent3/phase2/ddpg --gpu_device 2 --actor_weights state/ch2/agent3/phase1/ddpg_agent0_HiScore1.000000_actor_iter_481189.caffemodel --critic_weights state/ch2/agent3/phase1/ddpg_agent0_HiScore1.000000_critic_iter_481189.caffemodel --memory_snapshot state/ch2/agent3/phase1/ddpg_agent0_HiScore1.000000_iter_481189.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52030
./bin/dqn --save state/ch2/agent4/phase2/ddpg --gpu_device 3 --actor_weights state/ch2/agent4/phase1/ddpg_agent0_HiScore1.000000_actor_iter_481173.caffemodel --critic_weights state/ch2/agent4/phase1/ddpg_agent0_HiScore1.000000_critic_iter_481173.caffemodel --memory_snapshot state/ch2/agent4/phase1/ddpg_agent0_HiScore1.000000_iter_481173.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52033
./bin/dqn --save state/ch2/agent5/phase2/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase1/ddpg_agent0_HiScore1.000000_actor_iter_50137.caffemodel --critic_weights state/ch2/agent5/phase1/ddpg_agent0_HiScore1.000000_critic_iter_50137.caffemodel --memory_snapshot state/ch2/agent5/phase1/ddpg_agent0_HiScore1.000000_iter_50137.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase2/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase1/ddpg_agent0_HiScore1.000000_actor_iter_60124.caffemodel --critic_weights state/ch2/agent6/phase1/ddpg_agent0_HiScore1.000000_critic_iter_60124.caffemodel --memory_snapshot state/ch2/agent6/phase1/ddpg_agent0_HiScore1.000000_iter_60124.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase2/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase1/ddpg_agent0_HiScore1.000000_actor_iter_481272.caffemodel --critic_weights state/ch2/agent7/phase1/ddpg_agent0_HiScore1.000000_critic_iter_481272.caffemodel --memory_snapshot state/ch2/agent7/phase1/ddpg_agent0_HiScore1.000000_iter_481272.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase2/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase1/ddpg_agent0_HiScore1.000000_actor_iter_481144.caffemodel --critic_weights state/ch2/agent8/phase1/ddpg_agent0_HiScore1.000000_critic_iter_481144.caffemodel --memory_snapshot state/ch2/agent8/phase1/ddpg_agent0_HiScore1.000000_iter_481144.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52045
./bin/dqn --save state/ch2/agent9/phase2/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase1/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase1/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase1/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase2/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase1/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase1/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase1/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027 
```

#### Transfer Points

| Agent  | Snapshot                    | Iterations | Total Iterations  |
|--------|-----------------------------|-----------:|------------------:|
| Agent1 | HiScore1.000000_iter_50025  | 50,025     | 120,335			|
| Agent2 | HiScore1.000000_iter_60056  | 60,056     | 120,199			|
| Agent3 | HiScore1.000000_iter_480618 | 500,000    | 1,000,000			|
| Agent4 | HiScore1.000000_iter_490690 | 500,000    | 1,000,000			|
| Agent5 | HiScore0.990000_iter_290583 | 500,000    | 550,137			| 0.99
| Agent6 | HiScore0.980000_iter_350814 | 500,000    | 560,124			| 0.98
| Agent7 | HiScore1.000000_iter_490632 | 500,000    | 1,000,000			|
| Agent8 | HiScore1.000000_iter_350590 | 500,000    | 1,000,000			|
 



### Third Learning Phase

#### Overview

- Third learning phase involves agents standing near the foul line with the ball 0.1 meters outside of its kickable range. Objective is to learn to approach the ball and then kick it into the goal.
-- Agents 1-4 attempt to score against an empty goal
-- Agents 5-8 attempt to score against a defended goal

#### Execution Commands

These commands can be run in a tmux session or nohup

```bash
./bin/dqn --save state/ch2/agent1/phase3/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase2/ddpg_agent0_HiScore1.000000_actor_iter_50025.caffemodel --critic_weights state/ch2/agent1/phase2/ddpg_agent0_HiScore1.000000_critic_iter_50025.caffemodel --memory_snapshot state/ch2/agent1/phase2/ddpg_agent0_HiScore1.000000_iter_50025.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent2/phase3/ddpg --gpu_device 1 --actor_weights state/ch2/agent2/phase2/ddpg_agent0_HiScore1.000000_actor_iter_60056.caffemodel --critic_weights state/ch2/agent2/phase2/ddpg_agent0_HiScore1.000000_critic_iter_60056.caffemodel --memory_snapshot state/ch2/agent2/phase2/ddpg_agent0_HiScore1.000000_iter_60056.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
./bin/dqn --save state/ch2/agent3/phase3/ddpg --gpu_device 2 --actor_weights state/ch2/agent3/phase2/ddpg_agent0_HiScore1.000000_actor_iter_480618.caffemodel --critic_weights state/ch2/agent3/phase2/ddpg_agent0_HiScore1.000000_critic_iter_480618.caffemodel --memory_snapshot state/ch2/agent3/phase2/ddpg_agent0_HiScore1.000000_iter_480618.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52030
./bin/dqn --save state/ch2/agent4/phase3/ddpg --gpu_device 3 --actor_weights state/ch2/agent4/phase2/ddpg_agent0_HiScore1.000000_actor_iter_490690.caffemodel --critic_weights state/ch2/agent4/phase2/ddpg_agent0_HiScore1.000000_critic_iter_490690.caffemodel --memory_snapshot state/ch2/agent4/phase2/ddpg_agent0_HiScore1.000000_iter_490690.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52033
./bin/dqn --save state/ch2/agent5/phase3/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase2/ddpg_agent0_HiScore0.990000_actor_iter_290583.caffemodel --critic_weights state/ch2/agent5/phase2/ddpg_agent0_HiScore0.990000_critic_iter_290583.caffemodel --memory_snapshot state/ch2/agent5/phase2/ddpg_agent0_HiScore0.990000_iter_290583.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase3/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase2/ddpg_agent0_HiScore0.980000_actor_iter_350814.caffemodel --critic_weights state/ch2/agent6/phase2/ddpg_agent0_HiScore0.980000_critic_iter_350814.caffemodel --memory_snapshot state/ch2/agent6/phase2/ddpg_agent0_HiScore0.980000_iter_350814.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase3/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase2/ddpg_agent0_HiScore1.000000_actor_iter_490632.caffemodel --critic_weights state/ch2/agent7/phase2/ddpg_agent0_HiScore1.000000_critic_iter_490632.caffemodel --memory_snapshot state/ch2/agent7/phase2/ddpg_agent0_HiScore1.000000_iter_490632.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase3/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase2/ddpg_agent0_HiScore1.000000_actor_iter_350590.caffemodel --critic_weights state/ch2/agent8/phase2/ddpg_agent0_HiScore1.000000_critic_iter_350590.caffemodel --memory_snapshot state/ch2/agent8/phase2/ddpg_agent0_HiScore1.000000_iter_350590.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52045
./bin/dqn --save state/ch2/agent9/phase3/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase2/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase2/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase2/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase3/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase2/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase2/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase2/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027 
```

#### Transfer Points

| Agent  | Snapshot                    | Iterations | Total Iterations  |
|--------|-----------------------------|-----------:|------------------:|
| Agent1 | HiScore1.000000_iter_250427 | 250,427    | 370,762			|
| Agent2 | HiScore1.000000_iter_310619 | 310,619    | 430,818			|
| Agent3 | HiScore1.000000_iter_440248 | 500,000    | 1,500,000			|
| Agent4 | HiScore1.000000_iter_490384 | 500,000    | 1,500,000			|
| Agent5 | HiScore0.990000_iter_490531 | 500,000    | 1,050,137			| 0.99
| Agent6 | HiScore0.980000_iter_310363 | 500,000    | 1,060,124			| 0.98
| Agent7 | HiScore1.000000_iter_480612 | 500,000    | 1,500,000			| 
| Agent8 | HiScore0.990000_iter_410433 | 500,000    | 1,500,000			| 0.98




### Fourth Learning Phase

#### Overview

- Fourth learning phase involves agents standing near the foul line with the ball 5.0 meters outside of its kickable range. Objective is to sustain movement to the ball and then kick it into the goal.
-- Agents 1-4 attempt to score against an empty goal
-- Agents 5-8 attempt to score against a defended goal

#### Execution Commands

These commands can be run in a tmux session or nohup

```bash
./bin/dqn --save state/ch2/agent1/phase4/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase3/ddpg_agent0_HiScore1.000000_actor_iter_250427.caffemodel --critic_weights state/ch2/agent1/phase3/ddpg_agent0_HiScore1.000000_critic_iter_250427.caffemodel --memory_snapshot state/ch2/agent1/phase3/ddpg_agent0_HiScore1.000000_iter_250427.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent2/phase4/ddpg --gpu_device 1 --actor_weights state/ch2/agent2/phase3/ddpg_agent0_HiScore1.000000_actor_iter_310619.caffemodel --critic_weights state/ch2/agent2/phase3/ddpg_agent0_HiScore1.000000_critic_iter_310619.caffemodel --memory_snapshot state/ch2/agent2/phase3/ddpg_agent0_HiScore1.000000_iter_310619.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
./bin/dqn --save state/ch2/agent3/phase4/ddpg --gpu_device 2 --actor_weights state/ch2/agent3/phase3/ddpg_agent0_HiScore1.000000_actor_iter_440248.caffemodel --critic_weights state/ch2/agent3/phase3/ddpg_agent0_HiScore1.000000_critic_iter_440248.caffemodel --memory_snapshot state/ch2/agent3/phase3/ddpg_agent0_HiScore1.000000_iter_440248.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52030
./bin/dqn --save state/ch2/agent4/phase4/ddpg --gpu_device 3 --actor_weights state/ch2/agent4/phase3/ddpg_agent0_HiScore1.000000_actor_iter_490384.caffemodel --critic_weights state/ch2/agent4/phase3/ddpg_agent0_HiScore1.000000_critic_iter_490384.caffemodel --memory_snapshot state/ch2/agent4/phase3/ddpg_agent0_HiScore1.000000_iter_490384.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52033
./bin/dqn --save state/ch2/agent5/phase4/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase3/ddpg_agent0_HiScore0.990000_actor_iter_490531.caffemodel --critic_weights state/ch2/agent5/phase3/ddpg_agent0_HiScore0.990000_critic_iter_490531.caffemodel --memory_snapshot state/ch2/agent5/phase3/ddpg_agent0_HiScore0.990000_iter_490531.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase4/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase3/ddpg_agent0_HiScore0.980000_actor_iter_310363.caffemodel --critic_weights state/ch2/agent6/phase3/ddpg_agent0_HiScore0.980000_critic_iter_310363.caffemodel --memory_snapshot state/ch2/agent6/phase3/ddpg_agent0_HiScore0.980000_iter_310363.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase4/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase3/ddpg_agent0_HiScore1.000000_actor_iter_480612.caffemodel --critic_weights state/ch2/agent7/phase3/ddpg_agent0_HiScore1.000000_critic_iter_480612.caffemodel --memory_snapshot state/ch2/agent7/phase3/ddpg_agent0_HiScore1.000000_iter_480612.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase4/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase3/ddpg_agent0_HiScore0.990000_actor_iter_410433.caffemodel --critic_weights state/ch2/agent8/phase3/ddpg_agent0_HiScore0.990000_critic_iter_410433.caffemodel --memory_snapshot state/ch2/agent8/phase3/ddpg_agent0_HiScore0.990000_iter_410433.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52045
./bin/dqn --save state/ch2/agent9/phase4/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase3/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase3/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase3/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase4/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase3/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase3/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase3/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```

#### Transfer Points

| Agent  | Snapshot                    | Iterations | Total Iterations  |
|--------|-----------------------------|-----------:|------------------:|
| Agent1 | HiScore1.000000_iter_80050  | 80,050     | 450,812  			|
| Agent2 | HiScore1.000000_iter_30055  | 30,055     | 460,873 			|
| Agent3 | HiScore1.000000_iter_480164 | 500,000    | 2,000,000			|
| Agent4 | HiScore1.000000_iter_490347 | 500,000    | 2,000,000			|
| Agent5 | HiScore1.000000_iter_160130 | 160,130    | 1,210,267			|
| Agent6 | HiScore1.000000_iter_170071 | 170,071    | 1,230,195			|
| Agent7 | HiScore1.000000_iter_470270 | 500,000    | 2,000,000			|
| Agent8 | HiScore1.000000_iter_390267 | 500,000    | 2,000,000			|




### Fifth Learning Phase

#### Overview

- Fifth learning phase involves agents standing on the field with the ball placed randomly on the field. Objective is for the agent to locate and approach the ball, then kick it into the goal.
-- Agents 1-4 attempt to score against an empty goal
-- Agents 5-8 attempt to score against a defended goal

#### Execution Commands

These commands can be run in a tmux session or nohup

```bash
./bin/dqn --save state/ch2/agent1/phase5/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase4/ddpg_agent0_HiScore1.000000_actor_iter_80050.caffemodel --critic_weights state/ch2/agent1/phase4/ddpg_agent0_HiScore1.000000_critic_iter_80050.caffemodel --memory_snapshot state/ch2/agent1/phase4/ddpg_agent0_HiScore1.000000_iter_80050.replaymemory --offense_agents 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent2/phase5/ddpg --gpu_device 1 --actor_weights state/ch2/agent2/phase4/ddpg_agent0_HiScore1.000000_actor_iter_30055.caffemodel --critic_weights state/ch2/agent2/phase4/ddpg_agent0_HiScore1.000000_critic_iter_30055.caffemodel --memory_snapshot state/ch2/agent2/phase4/ddpg_agent0_HiScore1.000000_iter_30055.replaymemory --offense_agents 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
./bin/dqn --save state/ch2/agent3/phase5/ddpg --gpu_device 2 --actor_weights state/ch2/agent3/phase4/ddpg_agent0_HiScore1.000000_actor_iter_480164.caffemodel --critic_weights state/ch2/agent3/phase4/ddpg_agent0_HiScore1.000000_critic_iter_480164.caffemodel --memory_snapshot state/ch2/agent3/phase4/ddpg_agent0_HiScore1.000000_iter_480164.replaymemory --offense_agents 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52030
./bin/dqn --save state/ch2/agent4/phase5/ddpg --gpu_device 3 --actor_weights state/ch2/agent4/phase4/ddpg_agent0_HiScore1.000000_actor_iter_490347.caffemodel --critic_weights state/ch2/agent4/phase4/ddpg_agent0_HiScore1.000000_critic_iter_490347.caffemodel --memory_snapshot state/ch2/agent4/phase4/ddpg_agent0_HiScore1.000000_iter_490347.replaymemory --offense_agents 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52033

./bin/dqn --save state/ch2/agent5/phase5/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase4/ddpg_agent0_HiScore1.000000_actor_iter_160130.caffemodel --critic_weights state/ch2/agent5/phase4/ddpg_agent0_HiScore1.000000_critic_iter_160130.caffemodel --memory_snapshot state/ch2/agent5/phase4/ddpg_agent0_HiScore1.000000_iter_160130.replaymemory --offense_agents 1 --defense_dummies 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52036

./bin/dqn --save state/ch2/agent6/phase5/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase4/ddpg_agent0_HiScore1.000000_actor_iter_170071.caffemodel --critic_weights state/ch2/agent6/phase4/ddpg_agent0_HiScore1.000000_critic_iter_170071.caffemodel --memory_snapshot state/ch2/agent6/phase4/ddpg_agent0_HiScore1.000000_iter_170071.replaymemory --offense_agents 1 --defense_dummies 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase5/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase4/ddpg_agent0_HiScore1.000000_actor_iter_470270.caffemodel --critic_weights state/ch2/agent7/phase4/ddpg_agent0_HiScore1.000000_critic_iter_470270.caffemodel --memory_snapshot state/ch2/agent7/phase4/ddpg_agent0_HiScore1.000000_iter_470270.replaymemory --offense_agents 1 --defense_dummies 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase5/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase4/ddpg_agent0_HiScore1.000000_actor_iter_480280.caffemodel --critic_weights state/ch2/agent8/phase4/ddpg_agent0_HiScore1.000000_critic_iter_480280.caffemodel --memory_snapshot state/ch2/agent8/phase4/ddpg_agent0_HiScore1.000000_iter_480280.replaymemory --offense_agents 1 --defense_dummies 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52045

-- Try offense on ball
./bin/dqn --save state/ch2/agent5/phase5/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase4/ddpg_agent0_HiScore1.000000_actor_iter_160130.caffemodel --critic_weights state/ch2/agent5/phase4/ddpg_agent0_HiScore1.000000_critic_iter_160130.caffemodel --memory_snapshot state/ch2/agent5/phase4/ddpg_agent0_HiScore1.000000_iter_160130.replaymemory --offense_agents 1 --defense_dummies 1 --offense_on_ball 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52036

./bin/dqn --save state/ch2/agent6/phase5/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase4/ddpg_agent0_HiScore1.000000_actor_iter_170071.caffemodel --critic_weights state/ch2/agent6/phase4/ddpg_agent0_HiScore1.000000_critic_iter_170071.caffemodel --memory_snapshot state/ch2/agent6/phase4/ddpg_agent0_HiScore1.000000_iter_170071.replaymemory --offense_agents 1 --defense_dummies 1 --offense_on_ball 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase5/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase4/ddpg_agent0_HiScore1.000000_actor_iter_470270.caffemodel --critic_weights state/ch2/agent7/phase4/ddpg_agent0_HiScore1.000000_critic_iter_470270.caffemodel --memory_snapshot state/ch2/agent7/phase4/ddpg_agent0_HiScore1.000000_iter_470270.replaymemory --offense_agents 1 --defense_dummies 1 --offense_on_ball 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase5/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase4/ddpg_agent0_HiScore1.000000_actor_iter_480280.caffemodel --critic_weights state/ch2/agent8/phase4/ddpg_agent0_HiScore1.000000_critic_iter_480280.caffemodel --memory_snapshot state/ch2/agent8/phase4/ddpg_agent0_HiScore1.000000_iter_480280.replaymemory --offense_agents 1 --defense_dummies 1 --offense_on_ball 1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52045


./bin/dqn --save state/ch2/agent9/phase5/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase4/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase4/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase4/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase5/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase4/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase4/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase4/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_dummies 1 --offense_on_ball=1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```

#### Transfer Points

| Agent  | Snapshot                    | Iterations | Total Iterations  |
|--------|-----------------------------|-----------:|------------------:|
| Agent1 | HiScore0.990000_iter_300279 | 300,279    | 950,812  			|
| Agent2 | HiScore1.000000_iter_310367 | 310,367    | 771,240			|
| Agent3 | HiScore1.000000_iter_460344 | 500,000    | 2,500,000			|
| Agent4 | HiScore1.000000_iter_150117 | 500,000    | 2,500,000			|
| Agent5 | HiScore0.960000_iter_390467 | 500,000    | 1,710,267			|
| Agent6 | HiScore1.000000_iter_470371 | 470,371    | 1,700,566			|
| Agent7 | HiScore0.970000_iter_310266 | 500,000    | 2,500,000			|
| Agent8 | HiScore1.000000_iter_480490 | 500,000    | 2,500,000			|



### Sixth Learning Phase

#### Overview

- Sixth learning phase differs for Agents 1-4 and Agents 5-8
-- Agents 1-4 repeat learning phase 5 without full state information
-- Agents 5-8 will attempt to score against a goalie that is restricted to 0.1 max/min power

#### Execution Commands

These commands can be run in a tmux session or nohup

```bash
./bin/dqn --save state/ch2/agent1/phase6/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase5/ddpg_agent0_HiScore0.990000_actor_iter_300279.caffemodel --critic_weights state/ch2/agent1/phase5/ddpg_agent0_HiScore0.990000_critic_iter_300279.caffemodel --memory_snapshot state/ch2/agent1/phase5/ddpg_agent0_HiScore0.990000_iter_300279.replaymemory --offense_agents 1 --goal_reward_only --nofull_state --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent2/phase6/ddpg --gpu_device 1 --actor_weights state/ch2/agent2/phase5/ddpg_agent0_HiScore1.000000_actor_iter_310367.caffemodel --critic_weights state/ch2/agent2/phase5/ddpg_agent0_HiScore1.000000_critic_iter_310367.caffemodel --memory_snapshot state/ch2/agent2/phase5/ddpg_agent0_HiScore1.000000_iter_310367.replaymemory --offense_agents 1 --goal_reward_only --nofull_state --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
./bin/dqn --save state/ch2/agent3/phase6/ddpg --gpu_device 2 --actor_weights state/ch2/agent3/phase5/ddpg_agent0_HiScore1.000000_actor_iter_460344.caffemodel --critic_weights state/ch2/agent3/phase5/ddpg_agent0_HiScore1.000000_critic_iter_460344.caffemodel --memory_snapshot state/ch2/agent3/phase5/ddpg_agent0_HiScore1.000000_iter_460344.replaymemory --offense_agents 1 --goal_reward_only --nofull_state --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52030
./bin/dqn --save state/ch2/agent4/phase6/ddpg --gpu_device 3 --actor_weights state/ch2/agent4/phase5/ddpg_agent0_HiScore1.000000_actor_iter_150117.caffemodel --critic_weights state/ch2/agent4/phase5/ddpg_agent0_HiScore1.000000_critic_iter_150117.caffemodel --memory_snapshot state/ch2/agent4/phase5/ddpg_agent0_HiScore1.000000_iter_150117.replaymemory --offense_agents 1 --goal_reward_only --nofull_state --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52033

./bin/dqn --save state/ch2/agent5/phase6/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase5/ddpg_agent0_HiScore0.960000_actor_iter_390467.caffemodel --critic_weights state/ch2/agent5/phase5/ddpg_agent0_HiScore0.960000_critic_iter_390467.caffemodel --memory_snapshot state/ch2/agent5/phase5/ddpg_agent0_HiScore0.960000_iter_390467.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036

./bin/dqn --save state/ch2/agent6/phase6/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase5/ddpg_agent0_HiScore1.000000_actor_iter_470371.caffemodel --critic_weights state/ch2/agent6/phase5/ddpg_agent0_HiScore1.000000_critic_iter_470371.caffemodel --memory_snapshot state/ch2/agent6/phase5/ddpg_agent0_HiScore1.000000_iter_470371.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase6/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase5/ddpg_agent0_HiScore0.970000_actor_iter_310266.caffemodel --critic_weights state/ch2/agent7/phase5/ddpg_agent0_HiScore0.970000_critic_iter_310266.caffemodel --memory_snapshot state/ch2/agent7/phase5/ddpg_agent0_HiScore0.970000_iter_310266.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase6/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase5/ddpg_agent0_HiScore0.960000_actor_iter_450500.caffemodel --critic_weights state/ch2/agent8/phase5/ddpg_agent0_HiScore0.960000_critic_iter_450500.caffemodel --memory_snapshot state/ch2/agent8/phase5/ddpg_agent0_HiScore0.960000_iter_450500.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045



-- Try with offense on ball
./bin/dqn --save state/ch2/agent5/phase6/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase5/ddpg_agent0_HiScore0.980000_actor_iter_80057.caffemodel --critic_weights state/ch2/agent5/phase5/ddpg_agent0_HiScore0.980000_critic_iter_80057.caffemodel --memory_snapshot state/ch2/agent5/phase5/ddpg_agent0_HiScore0.980000_iter_80057.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase6/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase5/ddpg_agent0_HiScore1.000000_actor_iter_170149.caffemodel --critic_weights state/ch2/agent6/phase5/ddpg_agent0_HiScore1.000000_critic_iter_170149.caffemodel --memory_snapshot state/ch2/agent6/phase5/ddpg_agent0_HiScore1.000000_iter_170149.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase6/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase5/ddpg_agent0_HiScore0.990000_actor_iter_490342.caffemodel --critic_weights state/ch2/agent7/phase5/ddpg_agent0_HiScore0.990000_critic_iter_490342.caffemodel --memory_snapshot state/ch2/agent7/phase5/ddpg_agent0_HiScore0.990000_iter_490342.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase6/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase5/ddpg_agent0_HiScore0.980000_actor_iter_210210.caffemodel --critic_weights state/ch2/agent8/phase5/ddpg_agent0_HiScore0.980000_critic_iter_210210.caffemodel --memory_snapshot state/ch2/agent8/phase5/ddpg_agent0_HiScore0.980000_iter_210210.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045

./bin/dqn --save state/ch2/agent9/phase6/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase5/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase5/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase5/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball=1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase6/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase5/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase5/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase5/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball=1 --goalie_dash_attenuate 0.05 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```

#### Transfer Points

| Agent  | Snapshot                    | Iterations | Total Iterations  |
|--------|-----------------------------|-----------:|------------------:|
| Agent1 | HiScore1.000000_iter_190200 | 190,200    | 1,141,012  			|
| Agent2 | HiScore1.000000_iter_240138 | 240,138    | 1,011,378			|
| Agent3 | HiScore1.000000_iter_ | 500,000    | 3,000,000			|
| Agent4 | HiScore1.000000_iter_ | 500,000    | 3,000,000			|
| Agent5 | HiScore1.000000_iter_ | 500,000    | 1,710,267			|
| Agent6 | HiScore1.000000_iter_ | 470,371    | 1,700,566			|
| Agent7 | HiScore1.000000_iter_ | 500,000    | 2,500,000			|
| Agent8 | HiScore1.000000_iter_ | 500,000    | 2,500,000			|


### Seventh Learning Phase

```bash
./bin/dqn --save state/ch2/agent5/phase7/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase6/ddpg_agent0_HiScore0.960000_actor_iter_400387.caffemodel --critic_weights state/ch2/agent5/phase6/ddpg_agent0_HiScore0.960000_critic_iter_400387.caffemodel --memory_snapshot state/ch2/agent5/phase6/ddpg_agent0_HiScore0.960000_iter_400387.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase7/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase6/ddpg_agent0_HiScore0.980000_actor_iter_440344.caffemodel --critic_weights state/ch2/agent6/phase6/ddpg_agent0_HiScore0.980000_critic_iter_440344.caffemodel --memory_snapshot state/ch2/agent6/phase6/ddpg_agent0_HiScore0.980000_iter_440344.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase7/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase6/ddpg_agent0_HiScore0.950000_actor_iter_450543.caffemodel --critic_weights state/ch2/agent7/phase6/ddpg_agent0_HiScore0.950000_critic_iter_450543.caffemodel --memory_snapshot state/ch2/agent7/phase6/ddpg_agent0_HiScore0.950000_iter_450543.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase7/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase6/ddpg_agent0_HiScore0.940000_actor_iter_400610.caffemodel --critic_weights state/ch2/agent8/phase6/ddpg_agent0_HiScore0.940000_critic_iter_400610.caffemodel --memory_snapshot state/ch2/agent8/phase6/ddpg_agent0_HiScore0.940000_iter_400610.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042

-- Try with offense on ball
./bin/dqn --save state/ch2/agent5/phase7/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase6/ddpg_agent0_HiScore0.930000_actor_iter_180168.caffemodel --critic_weights state/ch2/agent5/phase6/ddpg_agent0_HiScore0.930000_critic_iter_180168.caffemodel --memory_snapshot state/ch2/agent5/phase6/ddpg_agent0_HiScore0.930000_iter_180168.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase7/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase6/ddpg_agent0_HiScore0.980000_actor_iter_300220.caffemodel --critic_weights state/ch2/agent6/phase6/ddpg_agent0_HiScore0.980000_critic_iter_300220.caffemodel --memory_snapshot state/ch2/agent6/phase6/ddpg_agent0_HiScore0.980000_iter_300220.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase7/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase6/ddpg_agent0_HiScore1.000000_actor_iter_370242.caffemodel --critic_weights state/ch2/agent7/phase6/ddpg_agent0_HiScore1.000000_critic_iter_370242.caffemodel --memory_snapshot state/ch2/agent7/phase6/ddpg_agent0_HiScore1.000000_iter_370242.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase7/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase6/ddpg_agent0_HiScore0.970000_actor_iter_190349.caffemodel --critic_weights state/ch2/agent8/phase6/ddpg_agent0_HiScore0.970000_critic_iter_190349.caffemodel --memory_snapshot state/ch2/agent8/phase6/ddpg_agent0_HiScore0.970000_iter_190349.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.10 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045

./bin/dqn --save state/ch2/agent9/phase7/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase6/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase6/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase6/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase7/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase6/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase6/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase6/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.1 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```

### Eigth Learning Phase



## Analysis

### Generate plots of each learning agent in sequence with the following code

```bash
./bin/dqn --save state/ch2/agent5/phase8/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase7/ddpg_agent0_HiScore0.950000_actor_iter_100062.caffemodel --critic_weights state/ch2/agent5/phase7/ddpg_agent0_HiScore0.950000_critic_iter_100062.caffemodel --memory_snapshot state/ch2/agent5/phase7/ddpg_agent0_HiScore0.950000_iter_100062.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase8/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase7/ddpg_agent0_HiScore0.920000_actor_iter_180136.caffemodel --critic_weights state/ch2/agent6/phase7/ddpg_agent0_HiScore0.920000_critic_iter_180136.caffemodel --memory_snapshot state/ch2/agent6/phase7/ddpg_agent0_HiScore0.920000_iter_180136.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase8/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase7/ddpg_agent0_HiScore0.930000_actor_iter_470407.caffemodel --critic_weights state/ch2/agent7/phase7/ddpg_agent0_HiScore0.930000_critic_iter_470407.caffemodel --memory_snapshot state/ch2/agent7/phase7/ddpg_agent0_HiScore0.930000_iter_470407.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase8/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase7/ddpg_agent0_HiScore0.880000_actor_iter_290251.caffemodel --critic_weights state/ch2/agent8/phase7/ddpg_agent0_HiScore0.880000_critic_iter_290251.caffemodel --memory_snapshot state/ch2/agent8/phase7/ddpg_agent0_HiScore0.880000_iter_290251.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042

-- Try with offense on ball
./bin/dqn --save state/ch2/agent5/phase8/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase7/ddpg_agent0_HiScore0.980000_actor_iter_280327.caffemodel --critic_weights state/ch2/agent5/phase7/ddpg_agent0_HiScore0.980000_critic_iter_280327.caffemodel --memory_snapshot state/ch2/agent5/phase7/ddpg_agent0_HiScore0.980000_iter_280327.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase8/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase7/ddpg_agent0_HiScore0.990000_actor_iter_460346.caffemodel --critic_weights state/ch2/agent6/phase7/ddpg_agent0_HiScore0.990000_critic_iter_460346.caffemodel --memory_snapshot state/ch2/agent6/phase7/ddpg_agent0_HiScore0.990000_iter_460346.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase8/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase7/ddpg_agent0_HiScore0.990000_actor_iter_380219.caffemodel --critic_weights state/ch2/agent7/phase7/ddpg_agent0_HiScore0.990000_critic_iter_380219.caffemodel --memory_snapshot state/ch2/agent7/phase7/ddpg_agent0_HiScore0.990000_iter_380219.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase8/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase7/ddpg_agent0_HiScore0.990000_actor_iter_320198.caffemodel --critic_weights state/ch2/agent8/phase7/ddpg_agent0_HiScore0.990000_critic_iter_320198.caffemodel --memory_snapshot state/ch2/agent8/phase7/ddpg_agent0_HiScore0.990000_iter_320198.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.20 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045

./bin/dqn --save state/ch2/agent9/phase8/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase7/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase7/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase7/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.2 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase8/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase7/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase7/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase7/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.2 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```



### Ninth Learning Phase
```bash
./bin/dqn --save state/ch2/agent5/phase9/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase8/ddpg_agent0_HiScore0.900000_actor_iter_120139.caffemodel --critic_weights state/ch2/agent5/phase8/ddpg_agent0_HiScore0.900000_critic_iter_120139.caffemodel --memory_snapshot state/ch2/agent5/phase8/ddpg_agent0_HiScore0.900000_iter_120139.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase9/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase8/ddpg_agent0_HiScore0.850000_actor_iter_390343.caffemodel --critic_weights state/ch2/agent6/phase8/ddpg_agent0_HiScore0.850000_critic_iter_390343.caffemodel --memory_snapshot state/ch2/agent6/phase8/ddpg_agent0_HiScore0.850000_iter_390343.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase9/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase8/ddpg_agent0_HiScore0.930000_actor_iter_140139.caffemodel --critic_weights state/ch2/agent7/phase8/ddpg_agent0_HiScore0.930000_critic_iter_140139.caffemodel --memory_snapshot state/ch2/agent7/phase8/ddpg_agent0_HiScore0.930000_iter_140139.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase9/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase8/ddpg_agent0_HiScore0.870000_actor_iter_430268.caffemodel --critic_weights state/ch2/agent8/phase8/ddpg_agent0_HiScore0.870000_critic_iter_430268.caffemodel --memory_snapshot state/ch2/agent8/phase8/ddpg_agent0_HiScore0.870000_iter_430268.replaymemory --offense_agents 1 --defense_npcs 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042

-- Try with offense on ball
./bin/dqn --save state/ch2/agent5/phase9/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase8/ddpg_agent0_HiScore0.940000_actor_iter_130128.caffemodel --critic_weights state/ch2/agent5/phase8/ddpg_agent0_HiScore0.940000_critic_iter_130128.caffemodel --memory_snapshot state/ch2/agent5/phase8/ddpg_agent0_HiScore0.940000_iter_130128.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase9/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase8/ddpg_agent0_HiScore0.940000_actor_iter_490496.caffemodel --critic_weights state/ch2/agent6/phase8/ddpg_agent0_HiScore0.940000_critic_iter_490496.caffemodel --memory_snapshot state/ch2/agent6/phase8/ddpg_agent0_HiScore0.940000_iter_490496.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase9/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase8/ddpg_agent0_HiScore0.980000_actor_iter_250113.caffemodel --critic_weights state/ch2/agent7/phase8/ddpg_agent0_HiScore0.980000_critic_iter_250113.caffemodel --memory_snapshot state/ch2/agent7/phase8/ddpg_agent0_HiScore0.980000_iter_250113.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase9/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase8/ddpg_agent0_HiScore0.980000_actor_iter_400420.caffemodel --critic_weights state/ch2/agent8/phase8/ddpg_agent0_HiScore0.980000_critic_iter_400420.caffemodel --memory_snapshot state/ch2/agent8/phase8/ddpg_agent0_HiScore0.980000_iter_400420.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045

./bin/dqn --save state/ch2/agent9/phase9/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase8/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase8/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase8/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase9/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase8/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase8/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase8/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.50 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```


Phase10
```bash
-- Try with offense on ball
./bin/dqn --save state/ch2/agent5/phase10/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase9/ddpg_agent0_HiScore0.830000_actor_iter_100081.caffemodel --critic_weights state/ch2/agent5/phase9/ddpg_agent0_HiScore0.830000_critic_iter_100081.caffemodel --memory_snapshot state/ch2/agent5/phase9/ddpg_agent0_HiScore0.830000_iter_100081.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.75 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase10/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase9/ddpg_agent0_HiScore0.920000_actor_iter_400376.caffemodel --critic_weights state/ch2/agent6/phase9/ddpg_agent0_HiScore0.920000_critic_iter_400376.caffemodel --memory_snapshot state/ch2/agent6/phase9/ddpg_agent0_HiScore0.920000_iter_400376.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.75 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase10/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase9/ddpg_agent0_HiScore0.890000_actor_iter_320330.caffemodel --critic_weights state/ch2/agent7/phase9/ddpg_agent0_HiScore0.890000_critic_iter_320330.caffemodel --memory_snapshot state/ch2/agent7/phase9/ddpg_agent0_HiScore0.890000_iter_320330.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.75 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase10/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase9/ddpg_agent0_HiScore0.880000_actor_iter_440387.caffemodel --critic_weights state/ch2/agent8/phase9/ddpg_agent0_HiScore0.880000_critic_iter_440387.caffemodel --memory_snapshot state/ch2/agent8/phase9/ddpg_agent0_HiScore0.880000_iter_440387.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.75 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045

./bin/dqn --save state/ch2/agent9/phase10/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase9/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase9/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase9/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.75 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase10/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase9/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase9/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase9/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 0.75 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```

Phase11
```bash
-- Try with offense on ball
./bin/dqn --save state/ch2/agent5/phase11/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase10/ddpg_agent0_HiScore0.340000_actor_iter_30075.caffemodel --critic_weights state/ch2/agent5/phase10/ddpg_agent0_HiScore0.340000_critic_iter_30075.caffemodel --memory_snapshot state/ch2/agent5/phase10/ddpg_agent0_HiScore0.340000_iter_30075.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 1.00 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase11/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase10/ddpg_agent0_HiScore0.660000_actor_iter_60024.caffemodel --critic_weights state/ch2/agent6/phase10/ddpg_agent0_HiScore0.660000_critic_iter_60024.caffemodel --memory_snapshot state/ch2/agent6/phase10/ddpg_agent0_HiScore0.660000_iter_60024.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 1.00 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase11/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase10/ddpg_agent0_HiScore0.860000_actor_iter_470441.caffemodel --critic_weights state/ch2/agent7/phase10/ddpg_agent0_HiScore0.860000_critic_iter_470441.caffemodel --memory_snapshot state/ch2/agent7/phase10/ddpg_agent0_HiScore0.860000_iter_470441.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 1.00 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase11/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase10/ddpg_agent0_HiScore0.710000_actor_iter_280367.caffemodel --critic_weights state/ch2/agent8/phase10/ddpg_agent0_HiScore0.710000_critic_iter_280367.caffemodel --memory_snapshot state/ch2/agent8/phase10/ddpg_agent0_HiScore0.710000_iter_280367.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 1.00 --goal_reward_only --beta 0.2 --explore 0 --noremove_old_snapshots --max_iter 500000 --port 52045

./bin/dqn --save state/ch2/agent9/phase11/ddpg --gpu_device 1 --actor_weights state/ch2/agent9/phase10/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent9/phase9/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent9/phase9/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 1.00 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent10/phase11/ddpg --gpu_device 2 --actor_weights state/ch2/agent10/phase10/ddpg_agent0_actor_iter_500000.caffemodel --critic_weights state/ch2/agent10/phase10/ddpg_agent0_critic_iter_500000.caffemodel --memory_snapshot state/ch2/agent10/phase10/ddpg_agent0_iter_500000.replaymemory --offense_agents 1 --defense_npcs 1 --offense_on_ball 1 --goalie_dash_attenuate 1.00 --goal_reward_only --beta 0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
```

```bash
./bin/dqn --save state/ch2/agent1/phase4/ddpg --gpu_device 0 --actor_weights state/ch2/agent1/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent1/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent1/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52024
./bin/dqn --save state/ch2/agent2/phase4/ddpg --gpu_device 1 --actor_weights state/ch2/agent2/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent2/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent2/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52027
./bin/dqn --save state/ch2/agent3/phase4/ddpg --gpu_device 2 --actor_weights state/ch2/agent3/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent3/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent3/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52030
./bin/dqn --save state/ch2/agent4/phase4/ddpg --gpu_device 3 --actor_weights state/ch2/agent4/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent4/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent4/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 5.0 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52033

./bin/dqn --save state/ch2/agent5/phase4/ddpg --gpu_device 4 --actor_weights state/ch2/agent5/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent5/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent5/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52036
./bin/dqn --save state/ch2/agent6/phase4/ddpg --gpu_device 5 --actor_weights state/ch2/agent6/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent6/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent6/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52039
./bin/dqn --save state/ch2/agent7/phase4/ddpg --gpu_device 6 --actor_weights state/ch2/agent7/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent7/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent7/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52042
./bin/dqn --save state/ch2/agent8/phase4/ddpg --gpu_device 7 --actor_weights state/ch2/agent8/phase3/ddpg_agent0_HiScore1.000000_actor_iter_xxxxx.caffemodel --critic_weights state/ch2/agent8/phase3/ddpg_agent0_HiScore1.000000_critic_iter_xxxxx.caffemodel --memory_snapshot state/ch2/agent8/phase3/ddpg_agent0_HiScore1.000000_iter_xxxxx.replaymemory --offense_agents 1 --defense_dummies 1 --ball_x_min=0.5 --ball_x_max=0.8 --ball_y_min=-0.3 --ball_y_max=0.3 --offense_on_ball=1 --beyond_kickable --offense_ball_dist 0.1 --goal_reward_only --beta=0.2 --noremove_old_snapshots --max_iter 500000 --port 52045
```





## Chapter 3 Experiments

Chapter 3 builds on some of the questions created by Chapter 2 and attempts to identify any characteristics that might identify optimal transfer points

## Chapter 4 Experiments

Chapter 4 explors the effectiveness of transfer learning by re




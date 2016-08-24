#ifndef TASK_HPP_
#define TASK_HPP_

#include <mutex>
#include <condition_variable>
#include <thread>
#include <HFO.hpp>
#include <glog/logging.h>
#include <gflags/gflags.h>
#include <boost/thread/barrier.hpp>

class Task {
 public:
  Task(std::string task_name, int offense_agents, int defense_agents);
  ~Task();

  // Takes an action in the environment
  virtual void act(int tid, hfo::action_t action, float arg1, float arg2);

  // Say a message in the environment
  virtual void say(int tid, const std::string& message);

  // Advances the environment. Returns new status and reward.
  std::pair<hfo::status_t, float> step(int tid);

  // Returns how much reward an agent can expect to accrue if performing well.
  virtual float getMaxExpectedReward() = 0;

  bool episodeOver() const { return episode_over_; }
  hfo::HFOEnvironment& getEnv(int tid);
  hfo::status_t getStatus(int tid) const;
  std::string getName() const { return task_name_; }
  float getEpisodeReward(int tid) const { return episode_reward_[tid]; }
  float getLastEpisodeReward(int tid) const { return last_episode_reward_[tid]; }
  int getNumAgents() const { return envs_.size(); }

 protected:
  virtual float getReward(int tid) = 0;
  void stepThread(int tid);
  hfo::status_t stepUntilEpisodeEnd(int tid);
  void startServer(int port, int offense_agents, int offense_npcs,
                   int defense_agents, int defense_npcs, bool fullstate=true,
                   int frames_per_trial=500, float ball_x_min=0., float ball_x_max=0.2,
                   int offense_on_ball=0);
  virtual void connectToServer(int tid);
  static float getDist(float o1_dist, float o1_ang_sin, float o1_ang_cos,
                       float o2_dist, float o2_ang_sin, float o2_ang_cos);


 protected:
  std::string task_name_;
  std::vector<std::thread> threads_;
  std::vector<hfo::HFOEnvironment> envs_;
  std::vector<hfo::status_t> status_;
  std::vector<std::mutex> mutexs_;
  std::vector<std::condition_variable> cvs_;
  std::vector<int> need_to_step_;
  std::vector<float> episode_reward_;
  std::vector<float> last_episode_reward_;
  int offense_agents_, defense_agents_;
  int server_port_;
  bool episode_over_;
  boost::barrier barrier_;
};

/**
 * MoveToBall task rewards the agent for approaching the ball.
 */
class MoveToBall : public Task {
 public:
  MoveToBall(int server_port, int offense_agents, int defense_agents,
             float ball_x_min=0.0, float ball_x_max=0.8);
  virtual float getMaxExpectedReward() { return 0.65; }
  static std::string taskName() { return "move_to_ball"; }

 protected:
  virtual float getReward(int tid) override;

  std::vector<float> old_ball_prox_;
  std::vector<float> ball_prox_delta_;
  std::vector<bool> first_step_;
};

/**
 * KickToGoal task initializes the agent with the ball and rewards the
 * agent for kicking the ball towards the goal.
 */
class KickToGoal : public Task {
 public:
  KickToGoal(int server_port, int offense_agents, int defense_agents,
             float ball_x_min=0.4, float ball_x_max=0.8);
  virtual float getMaxExpectedReward() { return 0.8; }
  static std::string taskName() { return "kick_to_goal"; }

 protected:
  virtual float getReward(int tid) override;

  std::vector<float> old_ball_dist_goal_;
  std::vector<float> ball_dist_goal_delta_;
  std::vector<bool> first_step_;
};

/**
 * Soccer task initializes the agent away from the ball and only
 * rewards the agent for scoring a goal.
 */
class Soccer : public Task {
 public:
  Soccer(int server_port, int offense_agents, int defense_agents);
  virtual float getMaxExpectedReward() { return 1; }
  static std::string taskName() { return "soccer"; }

 protected:
  virtual float getReward(int tid) override;
};

/**
 * The original soccer task features a more informative reward signal
 * that rewards the agent for going to the ball, and kicking to goal.
 */
class SoccerEasy : public Task {
 public:
  SoccerEasy(int server_port, int offense_agents, int defense_agents);
  virtual float getMaxExpectedReward() { return 8; }
  static std::string taskName() { return "soccer_easy"; }

 protected:
  virtual float getReward(int tid) override;

  std::vector<bool> first_step_;
  std::vector<float> old_ball_prox_;
  std::vector<bool> old_kickable_;
  std::vector<float> old_ball_dist_goal_;
  std::vector<bool> got_kickable_reward_;
};

/**
 * Dribble task encourages the agent to dribble the ball without going
 * out of bounds or losing control. The agent is initialized with the
 * ball.
 */
class Dribble : public Task {
 public:
  Dribble(int server_port, int offense_agents, int defense_agents);
  virtual float getMaxExpectedReward() { return 20; }
  static std::string taskName() { return "dribble"; }

 protected:
  virtual float getReward(int tid) override;
};

/**
 * Passing requires the agent to kick
 */
class Pass : public Task {
 public:
  Pass(int server_port, int offense_agents, int defense_agents);
  virtual float getMaxExpectedReward() { return 27; }
  static std::string taskName() { return "pass"; }

 protected:
  virtual float getReward(int tid) override;

  std::vector<bool> pass_active_;
  std::vector<hfo::Player> kicker_;
  std::vector<float> old_ball_prox_;
  std::vector<float> old_teammate_prox_;
  std::vector<float> old_ball_dist_teammate_;
  std::vector<bool> got_kickable_reward_;
};

/**
 * Cross task is a set play that requires the agent to pass to the
 * teammate before scoring.
 */
class Cross : public Task {
 public:
  Cross(int server_port, int offense_agents, int defense_agents,
        float ball_x_min=0.7, float ball_x_max=0.7);
  virtual float getMaxExpectedReward() { return 1; }
  static std::string taskName() { return "cross"; }

 protected:
  virtual float getReward(int tid) override;

  std::vector<hfo::Player> initial_pob_;
};

/**
 * The MirrorActions task rewards one agent for performing a task and
 * the other for mirroring the actions of the first. Agents are
 * penalized for repeating actions.
 */
class MirrorActions : public Task {
 public:
  MirrorActions(int server_port, int offense_agents, int defense_agents);
  virtual float getMaxExpectedReward() { return 1; }
  static std::string taskName() { return "mirror_actions"; }

  virtual void act(int tid, hfo::action_t action, float arg1, float arg2) override;

 protected:
  virtual float getReward(int tid) override;

  std::vector<hfo::action_t> actions_;
  std::vector<hfo::action_t> old_actions_;
};

#endif

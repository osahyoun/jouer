require 'spec_helper'

describe Jouer::Leaderboard do

  it "should display a leaderboard for teams" do
    Jouer::Game.log("score @bob @karen 2 @jane @frank 10")
    Jouer::Game.log("score @bob @karen 8 @jane @frank 10")
    Jouer::Game.log("score @bob @karen 10 @jane @frank 2")
    Jouer::Game.log("score @jom @jam 10 @fob @fib 5")
    
    Jouer::Leaderboard.teams.should == [
      ["frank jane", 2, 1 ],  # 1
      ["jam jom", 1, 0],      # 1
      ["bob karen", 1, 2],    # -1
      ["fib fob", 0, 1]       # -1
    ]
  end

end
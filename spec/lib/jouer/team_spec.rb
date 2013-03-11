require 'spec_helper'

describe Jouer::Team do
  before do
    @redis = Redis.new
    @redis.flushdb

    Jouer::Game.log("score @bob @karen 2 @jane @frank 10")
    Jouer::Game.log("score @karen @frank 10 @alice @michel 2")
    Jouer::Game.log("score @alice @frank 7 @karen @david 10")
    Jouer::Game.log("score @alice @bob 7 @karen @david 10")    
  end

  it "should know how many games a team has won" do
    Jouer::Team.new("frank", "karen").games_won?.should == 1
    Jouer::Team.new("karen", "david").games_won?.should == 2
  end

  it "should know the league table of scoring players" do
    Jouer::Team.league_table.should == [["david karen", 2.0], ["frank karen", 1.0], ["frank jane", 1.0]]
  end
end


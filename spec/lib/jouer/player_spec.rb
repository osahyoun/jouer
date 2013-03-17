require 'spec_helper'

describe Jouer::Player do
  before do
    @redis = Redis.new
    @redis.flushdb

    Jouer::Game.log("score @bob @karen 2 @jane @frank 10")
    Jouer::Game.log("score @karen @frank 10 @alice @michel 2")
    Jouer::Game.log("score @alice @frank 7 @karen @david 10")
    Jouer::Game.log("score @alice @bob 7 @karen @david 10")    
  end

  it "should return winning players" do
    Jouer::Player.winners.should == [
      ["karen", 3], 
      ["frank", 2], 
      ["david", 2], 
      ["jane", 1]
    ]
  end

  it "should return losing players" do
    Jouer::Player.losers.should == [
      ["alice", 3], 
      ["bob", 2], 
      ["michel", 1], 
      ["karen", 1], 
      ["frank", 1]
    ]
  end

  it "should return a players match history" do
    pending
  end

end
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

  it "should return winning teams" do
    Jouer::Team.winners.should == [
      ["david karen", 2],
      ["frank karen", 1],
      ["frank jane", 1]
    ]
  end

  it "should return losing teams" do
    Jouer::Team.losers.should == [
      ["bob karen", 1],
      ["alice michel", 1],
      ["alice frank", 1],
      ["alice bob", 1]
    ]
  end

  it "should return a teams match history" do
    pending
  end

end

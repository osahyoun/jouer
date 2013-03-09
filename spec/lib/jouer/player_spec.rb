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

  it "should know how many games a player has won" do
    Jouer::Player.new("frank").games_won?.should == 2
    Jouer::Player.new("karen").games_won?.should == 3
    Jouer::Player.new("david").games_won?.should == 2
    Jouer::Player.new("bob").games_won?.should == 0
  end

  it "should know how many games a play has lost" do
    Jouer::Player.new("frank").games_lost?.should == 1
    Jouer::Player.new("karen").games_lost?.should == 1
    Jouer::Player.new("david").games_lost?.should == 0
    Jouer::Player.new("bob").games_lost?.should == 2
  end
end
require 'spec_helper'

describe Jouer::Parser do

  it "should raise if string does not start with 'score'" do
    expect {
      Jouer::Parser.new("@do @re 2 @fa @so 10")
    }.to raise_error(ArgumentError)
  end

  it "should raise if string does not contain results for two teams" do
    expect {
      Jouer::Parser.new("score @do 2")
    }.to raise_error(ArgumentError)

    expect {
      Jouer::Parser.new("score @do @re 2 @fa 4")
    }.to raise_error(ArgumentError)

    expect {
      Jouer::Parser.new("score 2 @fo @bob 4")
    }.to raise_error(ArgumentError)
  end

  it "should parse players" do
    parser = Jouer::Parser.new("score @do @re 2 @fa @so 10")
    parser.parse.should == [["do", "re", "2"], ["fa", "so", "10"]]
  end

  it "should present teams and scores" do
    parser = Jouer::Parser.new("score @do @re 2 @so @fa 10")
    parser.to_hash.should == [{team: ['fa', 'so'], score: 10}, {team: ['do', 're'], score: 2}]
  end

  it "should know which team won" do
    parser = Jouer::Parser.new("score @do @re 2 @fa @so 10")
    parser.winners.should == ['fa', 'so']
  end

  it "should know which team lost" do
    parser = Jouer::Parser.new("score @do @re 2 @fa @so 10")
    parser.losers.should == ['do', 're']
  end

end

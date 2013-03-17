require 'spec_helper'

describe Jouer::View::LeagueTable do

  before do
    Jouer::Game.log("score @bob @karen 2 @jane @frank 10")
    Jouer::Game.log("score @karen @frank 10 @alice @michel 2")
    Jouer::Game.log("score @alice @frank 7 @karen @david 10")
    Jouer::Game.log("score @alice @bob 7 @karen @david 10")    
  end

  it "should correctly render league table as a text table" do
    pending
    table = Jouer::View::LeagueTable.new(Jouer::Team.league_table).render
    table.should == "fff"
  end

end
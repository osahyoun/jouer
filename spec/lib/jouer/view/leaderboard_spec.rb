require 'spec_helper'

describe Jouer::View::Leaderboard do

  before do
    Jouer::Game.log("score @bob @karen 2 @jane @frank 10")
    Jouer::Game.log("score @karen @frank 10 @alice @michel 2")
    Jouer::Game.log("score @karen @frank 9 @alice @michel 10")
    Jouer::Game.log("score @alice @frank 7 @karen @david 10")
    Jouer::Game.log("score @alice @bob 7 @karen @david 10")
  end

  it "should correctly render league table as a text table" do
    table = Jouer::View::Leaderboard.new(Jouer::Leaderboard.teams).render
    table.should match(/TEAM\s+|\s+GAMES WON\s+|\s+GAMES LOST\s+|/)
    table.should match(/|\s+david karen\s+|\s+2\s+|\s+0\s+|/)    
    table.should match(/|\s+alice bob\s+|\s+0\s+|\s+1\s+|/)
  end

end
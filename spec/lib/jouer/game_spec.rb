require 'spec_helper'

describe Jouer::Game do
  it "should track every game played" do
    now = Time.now

    Timecop.freeze(now) do
      Jouer::Game.log("score @bob @karen 2 @jane @frank 10")
    end

    past = Time.now - 100000

    Timecop.freeze(past) do
      Jouer::Game.log("score @karen @frank 10 @alice @michel 2")
    end

    @redis.zrevrange("games/history", 0, -1, with_scores: true).should == [
      [
        [{team: ['frank','jane'], score: 10}, {team: ['bob','karen'], score: 2}].to_json,
        now.to_i.to_f
      ],
      [
        [{team: ['frank','karen'], score: 10}, {team: ['alice','michel'], score: 2}].to_json,
        past.to_i.to_f
      ]
    ]
  end
end
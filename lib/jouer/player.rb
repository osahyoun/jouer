module Jouer
  class Player
    def initialize(name)
      @name = name
    end

    def self.league_table
      Connection.db.zrevrange("games_won/players", 0, -1, with_scores: true)
    end

    def games_won?
      Connection.db.zscore("games_won/player", @name).to_i
    end

    def games_lost?
      Connection.db.zscore("games_lost/player", @name).to_i
    end
  end
end
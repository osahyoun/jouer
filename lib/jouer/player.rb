module Jouer
  class Player
    def initialize(name)
      @name = name
    end

    def self.league_table
      Connection.db.zrevrange("games/players/won", 0, -1, with_scores: true)
    end

    def games_won?
      Connection.db.zscore("games/players/won", @name).to_i
    end

    def games_lost?
      Connection.db.zscore("games/players/lost", @name).to_i
    end
  end
end


# games/player/won
# games/plater/lost
# 
# games
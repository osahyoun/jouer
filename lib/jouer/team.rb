module Jouer
  class Team
    def initialize(*names)
      @names = names.sort
    end

    def self.league_table
      Connection.db.zrevrange("games/teams/won", 0, -1, with_scores: true)
    end

    def games_won?
      Connection.db.zscore("games/teams/won",  @names.join(' ')).to_i
    end

    def games_lost?
      Connection.db.zscore("games/teams/won", @names.join(' ')).to_i
    end
  end
end
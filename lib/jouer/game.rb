module Jouer
  class Game
    def initialize(detail)
      @detail = detail
    end

    def self.log(detail)
      new(detail).log
    end

    def self.history
      Connection.db.zrevrange("games/history", 0, -1, with_scores: true)      
    end

    def log
      Connection.db.zadd('games/history', Time.now.to_i, match_detail.to_hash.to_json)

      log_winners
      log_losers
    end

    def log_winners
      winning_team = match_detail.winners
      winning_team.each{|player| Connection.db.zincrby("games_won/player", 1, player) }

      Connection.db.zincrby("games_won/team", 1, winning_team.join(' '))
    end

    def log_losers
      losing_team = match_detail.losers
      losing_team.each{|player| Connection.db.zincrby("games_lost/player", 1, player) }
    end

    def match_detail
      @match_detail ||= Parser.new(@detail)
    end
  end
end
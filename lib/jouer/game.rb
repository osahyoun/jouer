module Jouer
  class Game
    STORAGE = {
      'history' => { write: :zadd, key: 'games/history' }
    }

    def initialize(detail)
      @detail = detail
    end

    def self.log(detail)
      new(detail).log
    end

    def redis
      @redis ||= Redis.new
    end

    def write(key, *opts)
      redis.send(STORAGE[key][:write], STORAGE[key][:key], *opts)
    end

    def read(key, *opts)
      redis.send(STORAGE[key][:read], key, *opts)
    end

    def log
      log_history
      log_winners
      log_losers
    end

    def log_history
      write('history', Time.now.to_i, match_detail.to_hash.to_json)
    end

    def log_winners
      winning_team = match_detail.winners
      winning_team.each{|player| Connection.db.zincrby("games/players/won", 1, player) }

      Connection.db.zincrby("games/teams/won", 1, winning_team.join(' '))
    end

    def log_losers
      losing_team = match_detail.losers
      losing_team.each{|player| Connection.db.zincrby("games/players/lost", 1, player) }
    end

    def match_detail
      @match_detail ||= Parser.new(@detail)
    end
  end
end
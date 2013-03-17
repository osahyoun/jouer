module Jouer
  class Game
    include Storage

    def initialize(match)
      @match = Parser.new(match)
    end

    def self.log(detail)
      new(detail).log
    end

    def log
      log_winners
      log_losers
    end

    def log_match
      store.hincrby(@match.winners, 'won', 1 )
      store.hincrby(@match.losers, 'lost', 1 )
    end

    def log_teams
      store.zadd "games/team/#{@match.winners.sub(' ', '+')}", Time.now.to_i, {team: @match.losers, outcome:'won', score: @match.score.to_json}.to_json
      store.zadd "games/team/#{@match.losers.sub(' ', '+')}", Time.now.to_i, {team: @match.winners, outcome:'lost', score: @match.score.to_json}.to_json    
    end

    def log_players
      @match.winners.split(' ').each{ |player| Connection.db.zincrby("games/players", 1, player) }
      @match.losers.split(' ').each{ |player| Connection.db.zincrby("games/players", -1, player) }      
    end

    def log_history
      write('history', Time.now.to_i, @match.to_hash.to_json)
    end

    def log_winners
      winning_team = @match.winners
      winning_team.split(' ').each{|player| Connection.db.zincrby("games/players/won", 1, player) }

      store.zincrby("games/teams/won", 1, winning_team)
    end

    def log_losers
      losing_team = @match.losers
      losing_team.split(' ').each{|player| store.zincrby("games/players/lost", 1, player) }

      store.zincrby("games/teams/lost", 1, losing_team)      
    end
  end
end
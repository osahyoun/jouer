module Jouer
  class Leaderboard

    class << self
      def teams
        board = []
        teams = (Team.winners.collect{|w| w[0]} + Team.losers.collect{|l| l[0]}).uniq
        teams.each do |team|
          item = [team]

          [Team.winners, Team.losers].each do |group|
            points = false
            group.each do |match|
              if match[0] == team
                item << match[1].to_i
                points = true
              end
            end
            item << 0 unless points
          end.sort_by{|x| x[1] - x[2]}
          board << item
        end

        board
      end

      def players

      end
    end

  end
end
module Jouer
  class Team
    extend Storage

    class << self
      def winners
        store.zrevrange("games/teams/won", 0, -1, with_scores: true).map do |t|
          t[1] = t[1].to_i
          t
        end
      end

      def losers
        store.zrevrange("games/teams/lost", 0, -1, with_scores: true).map do |t|
          t[1] = t[1].to_i
          t
        end
      end
    end

    def matches

    end

  end
end
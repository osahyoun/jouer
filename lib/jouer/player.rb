module Jouer
  class Player
    extend Storage
    include Storage

    def initialize(name)
      @name = name
    end

    def matches

    end

    class << self
      def winners
        store.zrevrange("games/players/won", 0, -1, with_scores: true).map do |t|
          t[1] = t[1].to_i
          t
        end
      end

      def losers
        store.zrevrange("games/players/lost", 0, -1, with_scores: true).map do |t|
          t[1] = t[1].to_i
          t
        end
      end
    end

  end
end

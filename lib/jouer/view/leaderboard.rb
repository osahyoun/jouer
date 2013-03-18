module Jouer
  module View
    class LeagueTable

      def initialize(data)
        @data = data
      end

      def header
        ["TEAM", "GAMES WON"]
      end

      def render
        ([header] + @data).to_table first_row_is_head: true
      end

    end
  end
end
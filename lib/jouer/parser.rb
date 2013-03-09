module Jouer
  class Parser
    PASS = /^score/
    PATTERN = /\s+@([a-z]+)\s+@([a-z]+)\s+(\d+)/

    def initialize(input)
      @input = input
      raise ArgumentError unless input =~ PASS
      raise ArgumentError unless parse.length == 2
    end

    def parse
      @input.scan(PATTERN)
    end

    def winners
      to_hash[0][:team]
    end

    def losers
      to_hash[1][:team]
    end

    def to_hash
      @hash ||= [
        {team: parse[0][0..1].sort, score: parse[0][2].to_i},
        {team: parse[1][0..1].sort, score: parse[1][2].to_i}
      ].sort_by { |h| h[:score] }.reverse
    end
  end
end
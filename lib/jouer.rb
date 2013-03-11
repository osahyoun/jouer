require 'redis'
require 'json'
require 'text-table'
require_relative 'jouer/player'
require_relative 'jouer/team'
require_relative 'jouer/parser'
require_relative 'jouer/game'
require_relative 'jouer/view/view'
require_relative 'jouer/view/league_table'



module Jouer
  module Connection
    REDIS_URI = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379")

    def self.db
      @db ||= Redis.new(:host => REDIS_URI.host, :port => REDIS_URI.port, :password => REDIS_URI.password)
    end
  end
end

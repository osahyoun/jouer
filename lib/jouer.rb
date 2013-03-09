require 'redis'
require 'json'
require 'jouer/player'
require 'jouer/team'
require 'jouer/parser'
require 'jouer/game'

module Jouer
  module Connection
    def self.db
      @db ||= Redis.new
    end
  end
end

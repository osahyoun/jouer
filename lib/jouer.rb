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
    def self.db
      @db ||= Redis.new
    end
  end
end

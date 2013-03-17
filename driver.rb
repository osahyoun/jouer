require 'hipchat-api'
require 'date'
require 'json'
require 'text-table'
require './lib/jouer'

class Driver
  HIPCHAT = HipChat::API.new(ENV["HIPCHAT_TOKEN"])

  def self.run
    while true
      messages = HIPCHAT.rooms_history(ENV["HIPCHAT_ROOM_ID"], "recent", "Europe/London").parsed_response["messages"]
      messages.each do |m|
        begin
          if Message.new(m).log
            HIPCHAT.rooms_message(ENV["HIPCHAT_ROOM_ID"], "foosball", Jouer::View::LeagueTable.new(Jouer::Team.league_table).render, 0, nil, 'text')
          end
        rescue ArgumentError # rescue if incorrect string is passed to Jouer parser
          puts "message not applicable"
        end
      end

      sleep 15
    end
  end

end



class Message
  def initialize(message)
    @date = message["date"]
    @message = message["message"]
  end

  def log
    unless already_logged?
      Jouer::Game.log(@message)
      Jouer::Connection.db.set('last_message', timestamp)
    end
  end

  def timestamp
    DateTime.strptime(@date, "%FT%T%z").to_time.to_i    
  end

  def already_logged?
    timestamp <= Jouer::Connection.db.get('last_message').to_i
  end
end

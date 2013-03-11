require 'hipchat-api'
require 'date'
require 'json'
require 'text-table'
require './lib/jouer'

class Driver
  ENV['HIPCHAT_TOKEN'] = '7164c495a2bde0a840b0bc177a86fb'
  ENV["HIPCHAT_ROOM_ID"] = '104737'
  
  HIPCHAT = HipChat::API.new(ENV["HIPCHAT_TOKEN"])

  def self.run
    table = %{<table width='200' border="2">
      <thead>
      <tr>
      <th align='left'>
      RANK
      </th>
      <th></th>
      <th>TEAM</th>
      <th>GAMES WON</th>
      </thead>
      <tbody>
        <tr>
          <td><strong>1.</strong></td>
          <td>&nbsp;</td>
          <td>Omar / Sarah</td>
          <td>10</td>
        </tr>
        <tr>
          <td><strong>2.</strong></td>
          <td>&nbsp;</td>        
          
          <td>Jake / Tom</td>
          <td>4</td>
        </tr>
        </tbody>
      </table>}
    

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

      p 'done. waiting 15 secs'
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

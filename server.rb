require 'socket'
require 'json'
require './game'

class Server
  attr_reader :server
  attr_accessor :games

  def initialize(ip, port)
    @ip = ip
    @port = port
    @server = TCPServer.open(@ip, @port)
    @games = {}
  end

  def start
    loop do
      Thread.start(server.accept) do |session|
        request_url = session.gets.split[1]
        case request_url
        when '/'
          @game = Game.new
          id = session.object_id
          @games[id] = @game
          session.puts Hash[id, @game.status].to_json

        when '/all'
          session.puts @games.to_json

        when %r{\d+\/shoot\/\d+}
          id = request_url[/\d+/].to_i
          coor = request_url[/\d+$/].to_i
          session.puts @games[id] ? @games[id].shoot(coor) : 'Not found'

        when %r{\d+\/save\/\d+}
          id = request_url[/\d+/].to_i
          coor = request_url[/\d+$/].to_i
          session.puts @games[id] ? @games[id].save(coor) : 'Not found'

        when %r{\d+\/show}
          id = request_url[/\d+/].to_i
          session.puts @games[id] ? @games[id].status.to_json : 'Not found'

        else
          session.puts 'I don\'t understand'
        end
        session.close
      end
    end
  end
end

Server.new('localhost', '1234').start

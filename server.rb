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
    @game = Game.new
  end

  def start
    loop do
      Thread.start(server.accept) do |session|
        request_url = session.gets.split[1]
        case request_url
        when '/'
          @game = Game.new
          @games[session.object_id] = @game
          response = @games
          session.puts response.to_json

        when '/show'
          session.puts @games

        when %r{shoot\/\d+}
          id = request_url.sub('/shoot/', '').to_i
          session.puts @games[id] ? @games[id].shoot : 'Not found'

        else
          session.puts 'I don\'t understand'
        end
        session.close
      end
    end
  end
end

Server.new('localhost', '1234').start

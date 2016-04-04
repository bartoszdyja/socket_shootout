require 'socket'
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
        request = session.gets
        request_url ||= request.split[1]
        case request_url
        when '/'
          session.puts 'Welcome to the game'
          session.puts 'Hit /start endpoint to begin.'
        when '/start'
          game = Game.new
          @games[session.__id__] = game
          session.puts @games
        when %r{show\/\d+}
          id = request_url.sub('/show/', '').to_i
          session.puts @games[id] ? @games[id].status : 'Game not found'
        else
          session.puts 'I don\'t understand'
        end
        session.close
      end
    end
  end
end

Server.new('localhost', '1234').start

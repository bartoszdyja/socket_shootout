require 'socket'
require './game'

class Server
  attr_reader :server
  attr_accessor :games

  def initialize(ip, port)
    @ip = ip
    @port = port
    @server = TCPServer.open(@ip, @port)
    @games = []
    @game = Game.new
  end

  def start
    loop do
      conn = server.accept
      request = conn.gets
      request_url ||= request.split[1]
      case request_url
      when "/"
        conn.puts 'Welcome to the game'
        conn.puts 'Hit /start endpoint to begin.'
      when '/start'
        @game = Game.new
        @games << @game
        conn.puts @game.status
      when %r(show\/\d+)
        id = request_url.sub('/show/', '')
        conn.puts id
      when '/show'
        # conn.puts @games
        conn.puts @games.map(&:status)
      else
        conn.puts 'I don\'t understand'
      end
      conn.close
    end
  end
end

Server.new('localhost', '1234').start

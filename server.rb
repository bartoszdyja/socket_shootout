require 'socket'
require './game'

class Server
  attr_reader :server

  def initialize(ip, port)
    @ip = ip
    @port = port
    @server = TCPServer.open(@ip, @port)
    @game = Game.new
    @games = {}
  end

  def start
    loop do
      conn = server.accept
      request = conn.gets.split[1]
      case request
      when '/start'
        conn.puts 'start request'
      when '/shoot'
        conn.puts 'shoot'
      else
        conn.puts 'I don\'t understand'
      end
      conn.close
    end
  end
end

Server.new('localhost', '1234').start

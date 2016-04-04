require 'socket'

class Server
  attr_reader :server
  def initialize(ip, port)
    @ip = ip
    @port = port
    @server = TCPServer.open(@ip, @port)
  end

  def start
    loop do
      conn = server.accept
      conn.puts 'Hello'
      conn.close
    end
  end
end

Server.new('localhost', '1234').start

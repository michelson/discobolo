require 'celluloid/io'

module Discobolo
  class SocketClient
    include Celluloid::IO
    finalizer :finalize

    def initialize(socket_path)
      Discobolo::Config.logger.info "connecting to #{socket_path}"
      @socket_path = socket_path
      @socket = UNIXSocket.new(socket_path)
    end

    def echo(msg)
      Discobolo::Config.logger.info "send to server: '#{msg}'"
      @socket.puts(msg)
      #data = @socket.readline.chomp
      data = @socket.gets.chomp
      Discobolo::Config.logger.info "server unswer '#{data}'"
      JSON.parse(data)
    end

    def finalize
      @socket.close if @socket
    end

  end
end
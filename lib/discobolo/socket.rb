require 'celluloid/io'
require 'celluloid/autostart'

module Discobolo
  class Socket

    UNIX_SOCKET_FILE = "/tmp/discobolo_stats"

    include Celluloid::IO
    finalizer :finalize

    attr_reader :socket_path, :server

    def initialize(socket_path = UNIX_SOCKET_FILE)
      FileUtils.rm( socket_path) rescue "bu"
      Discobolo::Config.logger.info "start server #{socket_path}"
      @socket_path = socket_path
      @server = UNIXServer.open(socket_path)
      async.run
    end

    def run
      loop { async.handle_connection @server.accept }
    end

    def handle_connection(socket)
      loop do
        data = socket.readline
        Discobolo::Config.logger.info "gets data #{data}"
        socket.write(handle_message(data))
      end

    rescue EOFError
      Discobolo::Config.logger.info "disconnected"

    ensure
      socket.close
    end

    def finalize
      if @server
        @server.close
        File.delete(@socket_path)
      end
    end

    def handle_message(msg)
      reponse = ""
      case msg.chomp
      when "stats"
        response = get_stats
      when "stop"
        #TODO: implement stop
      when "kill"
        #TODO: implement kill
      end
      response
    end

    def get_stats

      sup = Discobolo::Application.supervisor

      state = sup.instance_variable_get("@state")

      actor_list = sup.actors.last.actors.map do |a|
        {leaked: a.leaked?, tasks: a.tasks.map{|o| o.status} }
      end

      hshs = {
        supervisor_status: sup.instance_variable_get("@state"),
        workers_size: Celluloid::Actor[:discobolo_pool].actors.size,
        actors: actor_list
      }

      return hshs.to_json.to_s + "\n"

    end

  end
end

  

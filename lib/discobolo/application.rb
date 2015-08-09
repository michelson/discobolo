module Discobolo
  class Application

    class << self
      attr_reader :supervisor, :socket
    end

    def self.run
      spawn_socket
      #Discobolo::Supervisor.new
      #@supervisor.register_queues
      #@supervisor.actors.each{|o| o.async.fetch }
      #@supervisor.class.run
      @supervisor = Discobolo::Supervisor.run!
      self
    end

    def self.actors
      @supervisor
    end

    def self.spawn_socket
      @socket = Discobolo::Socket.supervise  
      trap("INT") { 
        @socket.terminate; 
        @supervisor.terminate; 
        exit 
      }
    end

  end
end
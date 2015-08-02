module Discobolo
  class Application

    def self.run
      @supervisor = Discobolo::Supervisor.new
      @supervisor.register_queues
      @supervisor.actors.each{|o| o.async.fetch }
      self
    end

    def self.actors
      @supervisor
    end

  end
end
module Discobolo
 
  class Supervisor < Celluloid::SupervisionGroup
    
    def register_queues
      self.pool Discobolo::Actor, size: self.class.concurrency,
                                  as: :discobolo_pool,
                                  args: { fetch: true } 

      Discobolo::Config.logger.info "#{self.actors.size} registered actors"
      self
    end

    def self.concurrency
      Discobolo::Config.actor_concurrency
    end

  end
end

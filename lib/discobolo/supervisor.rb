module Discobolo
 
  class Supervisor < Celluloid::Supervision::Container
    #Celluloid::SupervisionGroup
    #pool Discobolo::Actor, as: :discobolo_pool, size: 5, 
    #  args: [{ fetch: true }]

    supervise type: Discobolo::Fetcher, 
              as: :"discobolo_fetcher", 
              args: [{fetch: true}]

    self.pool Discobolo::Actor, size: Discobolo::Config.actor_concurrency,
                                as: :discobolo_pool
    
    def register_queues

     
        #self.pool Discobolo::Actor, size: self.class.concurrency,
        #                            as: :discobolo_pool,
        #                            args: { fetch: true } 
     

      Discobolo::Config.logger.info "#{self.actors.size} registered actors with actor concurrency of #{self.class.concurrency}"
      self
    end

    def self.concurrency
      Discobolo::Config.actor_concurrency
    end

  end
end

module Discobolo
 
  class Supervisor < Celluloid::SupervisionGroup
    #supervise MyActor, as: :my_actor
    #supervise AnotherActor, as: :another_actor, args: [{start_working_right_now: true}]
    #pool MyWorker, as: :discobolo_pool, size: 5

    def register_queues

      Discobolo::Config.queues.each do |queue|
        self.supervise(Discobolo::Actor, as: queue , args: {queue: queue} )   
      end

      puts "#{self.actors.size } registered actors"

      self
    end

  end
end

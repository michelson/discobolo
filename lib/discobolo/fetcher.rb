module Discobolo
  class Fetcher

    include Celluloid

    attr_accessor :queues

    def initialize(*args)
      args = Hash[*args.flatten] if args.is_a?(Array)
      Discobolo::Config.logger.info "Initialize actor with: #{args}"
      @queues = Discobolo::Config.queues
      async.fetch if args[:fetch]
    end

    def fetch
      client = Discobolo::Config.client
      #Discobolo::Config.logger.info "Listen Disque queues: #{self.queues} with concurrency of #{Discobolo::Config.actor_concurrency} workers"
      options = Discobolo::Config.fetch_options.merge({from: self.queues})
      
      jobs = client.fetch(options)
      jobs.to_a.each do |queue, job_id, options|
        Discobolo::Config.logger.info "#{queue} queue: received #{job_id} received #{options}"
        
        Celluloid::Actor[:discobolo_pool].handle_job(job_id, options)
      end

      sleep 1
      fetch
    end


  end

end
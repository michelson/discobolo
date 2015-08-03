module Discobolo
  class Actor
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
      Discobolo::Config.logger.info "Listen Disque queues: #{self.queues} with concurrency of #{Discobolo::Config.actor_concurrency} workers"
      options = Discobolo::Config.fetch_options.merge({from: self.queues})
      loop do
        jobs = client.fetch(options)
        jobs.to_a.each do |queue, job_id, options|
          Discobolo::Config.logger.info "#{queue} queue: received #{job_id} received #{options}"
          
          #since we are supervising the actor, let it crash
          #begin
            # Claims to be still working with the specified job
            #client.working(job_id)

            options = JSON.parse(options)
            klass = Object.const_get(options['class'])
            instance = klass.new
            instance.job_id = job_id
            instance.async.perform_async(*options['args'])

          #rescue => e
          # Discobolo::Config.logger.error "Terrible error happened #{e}"
          #end 

        end
      end
    end

  end
end
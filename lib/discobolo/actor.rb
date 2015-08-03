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
      loop do
        jobs = client.fetch(from: self.queues, count: 10, timeout: 2000)
        jobs.to_a.each do |queue, job_id, options|
          Discobolo::Config.logger.info "#{queue} queue: received #{job_id} received #{options}"
          begin
            options = JSON.parse(options)
            klass = Object.const_get(options['class'])
            instance = klass.new
            instance.job_id = job_id
            instance.async.perform_async(*options['args'])
          rescue => e
            Discobolo::Config.logger.error "Terrible error happened #{e}"
          end 
        end
      end
    end

  end
end
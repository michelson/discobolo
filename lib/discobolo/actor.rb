module Discobolo
  class Actor
    include Celluloid

    attr_accessor :queues

    def initialize(*args)
      args = Hash[*args.flatten] if args.is_a?(Array)
      Discobolo::Config.logger.info "Initialize actor with: #{args}"
      @queues = Discobolo::Config.queues
    end

    def handle_job(job_id, options)
      options = JSON.parse(options)
      klass = Object.const_get(options['class'])
      instance = klass.new
      instance.job_id = job_id
      instance.async.perform_async(*options['args'])
    end
  end
end
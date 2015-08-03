module Discobolo
  class Worker
    include Celluloid
    attr_accessor :queue, :job_id

    class << self
      attr_accessor :queue
    end

    def perform_async(*args)
      perform(*args)
      Discobolo::Config.client.call('ACKJOB', self.job_id)
      Discobolo::Config.logger.info "Finished job #{self.job_id}"
    end

    def self.enqueue(message, options={})
      timeout = options.delete(:timeout) || 100
      opts = {ttl: 1, async: true}.merge(options)
      #Discobolo::Config.logger.info "Enqueue from #{self.name} to queue #{@queue}"
      Discobolo::Config.client.push(@queue, format_msg(message), timeout, opts)
    end

    def self.set_queue(queue)
      self.queue = queue
    end

private
    def self.format_msg(message)
      {class: self.name, args: message}.to_json
    end

  end
end

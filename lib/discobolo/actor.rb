module Discobolo
  class Actor
    include Celluloid

    attr_accessor :queue

    def initialize(*args)
      args = Hash[*args.flatten] if args.is_a?(Array)
      puts "Initialize actor with: #{args}"
      @queue = args[:queue]
      async.fetch if args[:fetch]
    end

    def push(message, args={})
      Discobolo::Config.client.push(self.queue, message, 100, *args)
    end

    def fetch
      client = Discobolo::Config.client
      puts "Listen Disque queue: #{self.queue}"
      loop do
        jobs = client.fetch(from: self.queue, count: 10, timeout: 2000)
        jobs.to_a.each do |queue, job_id, options|
          puts "#{queue} queue: received #{job_id} received #{options}"
          begin
            options = JSON.parse(options)
            klass = Object.const_get(options['class'])
            instance = klass.new
            instance.job_id = job_id
            instance.async.perform_async(*options['args'])
          rescue => e
            puts "Terrible error happened #{e}"
          end 
        end
      end
    end

  end
end
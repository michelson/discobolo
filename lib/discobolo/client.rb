module Discobolo
  class Client < Disque

    def show(jobid)
      Hash[ *call("SHOW", jobid)]
    end

    def working(jobid)
      call("WORKING", jobid)
    end

    def queue_lenght(queue)
      call("QLEN", queue)
    end

    def dequeue(queue)
      call("DEQUEUE", queue)
    end

    def enqueue(queue)
      call("ENQUEUE", queue)
    end

    def queue_stat(queue)
      Discobolo::Config.logger.error("QSTAT not implemented yet")
      #call("QSTAT", queue)
    end

    def jscan(queue, page=0, count=30)
      jobs = []
      Discobolo::Config.client.call("JSCAN", page, "COUNT", count, "QUEUE" , queue, "REPLY", "all").each do |job|
        next if job.is_a? String
        next if job.empty?
        job.each do |j|
          jobs << { results: Hash[*j] }
        end
      end.compact
      jobs
      #binding.pry
    end

    def info
      call("INFO")
    end

  end
end
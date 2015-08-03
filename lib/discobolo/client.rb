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

    def queue_stat(queue)
      Discobolo::Config.logger.error("QSTAT not implemented yet")
      #call("QSTAT", queue)
    end

  end
end
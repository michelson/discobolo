require "discobolo"
require "pry"

# EXAMPLE WORKERS FOR QUEUES

class BogusWorker < Discobolo::Worker
  set_queue "bogus"

  def perform(*args)
    puts "Performing from BogusWorker"
    puts "With #{job_id} #{args} "
  end
end

class ImportantWorker < Discobolo::Worker
  set_queue "important"

  def perform(*args)
    puts "Performing from ImportantWorker"
    puts "With #{job_id} #{args} "
  end
end

class DefaultWorker < Discobolo::Worker
  set_queue "default"

  def perform(*args)
    puts "Performing from DefaultWorker"
    puts "With #{job_id} #{args} "
  end
end


# APPLICATION SETUP

Discobolo::Config.setup do |config|
  config.client = ["127.0.0.1:7711"]
  config.queues = ["default", "important", "bogus"]
  config.fetch_options = {count: 10, timeout: 2000}
end

@client = Discobolo::Config.client
@app = Discobolo::Application

##USAGE

# you need 2 terminal sessions

# TERMINAL 1 execute `bundle exec rake console`
# rake console
# $> @app.run

# TERMINAL 2 execute `bundle exec rake console`
# rake console
# $>  DefaultWorker.enqueue("Hello")
# $>  ImportantWorker.enqueue([1,2,3,4])
# $>  BogusWorker.enqueue({b:323 , c:"dslihjoikmkkkmkmmjj"})

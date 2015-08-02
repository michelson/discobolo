require "discobolo"
require "pry"

class MyWorker < Discobolo::Worker
  set_queue "bogus"

  def perform(*args)
    puts "Performing from MyWorker"
    puts "With #{job_id} #{args} "
  end
end

Discobolo::Config.setup do |config|
config.client = ["127.0.0.1:7711"]
config.queues = ["default", "important", "bogus"]
  config.fetch_options = {count: 10, timeout: 2000}
end

@client = Discobolo::Config.client
@app = Discobolo::Application
#@app.run
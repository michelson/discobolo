require "spec_helper"

describe Discobolo::Worker do 
	
    class MyWorker < Discobolo::Worker
      set_queue "bogus"

      def perform(*args)
        puts "Performing from MyWorker"
        puts "With #{job_id} #{args} "
      end
    end

  before do 
    Discobolo::Config.setup do |config|
			config.client = ["127.0.0.1:7711"]
		  config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

	end

  it "will have a queue at class level" do 
    expect(MyWorker.queue).to be == "bogus"
  end

end
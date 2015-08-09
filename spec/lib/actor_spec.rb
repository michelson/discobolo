require "spec_helper"

describe Discobolo::Actor do 
	before do 
    Discobolo::Config.setup do |config|
			config.client = ["127.0.0.1:7711"]
		  config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

    class MyWorker < Discobolo::Worker
      set_queue "default"
    end

	end

  it "fetch will perform" do 
    actor = Discobolo::Actor.new
    expect_any_instance_of(MyWorker).to receive(:perform_async).at_most(1).times
    actor.handle_job("123", {"class"=>"MyWorker", :args=>{:a=> "6"} }.to_json)
  end

end
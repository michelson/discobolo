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

  it "register queues will" do 
    actor = Discobolo::Actor.new(queues: ["default"])
    expect(actor.queues).to include("default")
  end

  it "fetch will perform" do 
    actor = Discobolo::Actor.new(queues: ["default"])
    expect(actor.queues).to include("default")
    expect_any_instance_of(MyWorker).to receive(:async).at_most(1).times
    actor.async.fetch()
    MyWorker.enqueue("hello")
  end

end
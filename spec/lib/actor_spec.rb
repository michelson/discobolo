require "spec_helper"

describe Discobolo::Actor do 
	before do 
    Discobolo::Config.setup do |config|
			config.client = ["127.0.0.1:7711"]
		  config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

	end

  it "register queues will" do 
    actor = Discobolo::Actor.new(queue: "default")
    expect_any_instance_of(Disque).to receive(:push).at_most(1).times
    actor.push("hello")
  end

  it "will transform string to class" do 
    actor = Discobolo::Actor.new(queue: "default")
    expect(actor.send(:to_class, "String")).to be == String    
  end
end
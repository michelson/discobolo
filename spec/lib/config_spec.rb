require "spec_helper"

describe Discobolo::Config do 
	it "will setup" do 
		
    Discobolo::Config.setup do |config|
			config.client = ["127.0.0.1:7711"]
		  config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

    expect(Discobolo::Config.client.class).to be Disque
    expect(Discobolo::Config.queues).to include("default")
    expect(Discobolo::Config.fetch_options).to_not be_nil

	end
end
require "spec_helper"

describe Discobolo::Supervisor do 
	before do 
    Discobolo::Config.setup do |config|
			config.client = ["127.0.0.1:7711"]
		  config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

	end

  it "register queues will instantiate actors" do 
    supervisor = Discobolo::Supervisor.new
    supervisor.async.register_queues
    expect(supervisor.actors.size).to be == 1
    expect(supervisor.actors.map(&:queues)).to include("default")
  end
end
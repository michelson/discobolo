require "spec_helper"

describe Discobolo::Supervisor do 
	before do 
    Discobolo::Config.setup do |config|
			config.client = ["127.0.0.1:7711"]
		  config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

	end

  it "register queues will instantiate fetcher and worker pool" do 
    supervisor = Discobolo::Supervisor.run!
    expect(supervisor.actors.size).to be == 2
    expect(supervisor.actors.map{|o| o.registered_name }).to include(:discobolo_fetcher)
    expect(supervisor.actors.map{|o| o.registered_name }).to include(:discobolo_pool)
  end

  it "pool concurrency default" do 
    supervisor = Discobolo::Supervisor.run!
    expect(Celluloid::Actor[:discobolo_pool].actors.size).to be == 5
  end
end
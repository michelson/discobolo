require "spec_helper"



describe Discobolo::Actor do 
	before do 

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
	end

  it "will receive messages" do 
    #puts "oli"
    #expect_any_instance_of(MyWorker).to receive(:perform).at_most(1).times
    #sleep 4
    #puts "chaia"
    #@client.push("bogus", {"class"=>"MyWorker", :args=>{:a=> "1"} }.to_json, 100)
    #puts "chaia 2"
    #@client.push("bogus", {"class"=>"MyWorker", :args=>{:a=> "1"} }.to_json, 100)
    #@client.push("bogus", {"class"=>"MyWorker", :args=>{:a=> "1"} }.to_json, 100)
    #@client.push("bogus", {"class"=>"MyWorker", :args=>{:a=> "1"} }.to_json, 100)
  end
end
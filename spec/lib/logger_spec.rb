require "spec_helper"

describe Discobolo::Logger do 
  before do 
    Discobolo::Config.setup do |config|
      config.client = ["127.0.0.1:7711"]
      config.queues = ["default"]
      config.fetch_options = {count: 10, timeout: 2000}
    end

  end

  it "extends Logger" do 
    expect(Discobolo::Config.logger.class.ancestors).to include(Logger)
  end
end
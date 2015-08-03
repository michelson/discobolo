require "spec_helper"

describe Discobolo::Client do 
  

  let(:client){
    Discobolo::Client.new(["127.0.0.1:7711"])
  }
  
  it "extends Disque" do 
    expect(client.class.ancestors).to include(Disque)
  end

end
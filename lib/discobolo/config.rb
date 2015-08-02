
module Discobolo
 
  class Config

    class << self
      attr_accessor :client, :queues, :fetch_options, :auth
    end

    def self.setup
      yield self
    end

    def self.client=(nodes)
      #client = Disque.new("127.0.0.1:7711", auth: "e727d1464a...")
      @client = Disque.new(nodes)
    end

  end

end
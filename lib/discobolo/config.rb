
module Discobolo
 
  class Config

    class << self
      attr_accessor :client, :queues, :fetch_options, :auth, :actor_concurrency
    end

    def self.setup
      yield self
    end

    def self.client=(nodes)
      #client = Disque.new("127.0.0.1:7711", auth: "e727d1464a...")
      @client = Client.new(nodes)
    end

    def self.logger=(arg=nil)
      l = arg.nil? ? arg : $stdout
      @logger = Discobolo::Logger.new(l)
    end

    def self.logger
      @logger || Discobolo::Logger.new($stdout)
    end

    def actor_concurrency
      @actor_concurrency || 5
    end

  end

end

module Discobolo
 
  class Config

    class << self
      attr_accessor :client, 
                    :queues, 
                    :fetch_options, 
                    :auth, 
                    :actor_concurrency
    end

    def self.setup
      yield self
    end

    def self.client=(nodes)
      #client = Disque.new("127.0.0.1:7711", auth: "e727d1464a...")
      @client = Client.new(nodes)
    end

    def self.stats=(type, opts={})
      $disque_stats ||= Discobolo::Stats.register(type.to_sym, opts)
      $disque_stats.setup
    end

    def self.logger=(arg=nil)
      l = arg.nil? ? arg : $stdout
      @logger = Discobolo::Logger.new(l)
    end

    def self.logger
      @logger || Discobolo::Logger.new($stdout)
    end

    def self.actor_concurrency
      @actor_concurrency || 5
    end

    def self.fetch_options
      @fetch_options || {count: 10, timeout: 2000}
    end

  end

end
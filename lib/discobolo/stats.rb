

module Discobolo
  module Stats
    autoload :Influxdb, 'discobolo/stats/influxdb'

    class << self

      def register(type, opts)
        klass = "Discobolo::Stats::#{type.to_s.capitalize}"
        @client = Object.const_get(klass).new(opts)
      end

      def add(jobid,opts)
        @client.add(opts)
      end

    end
  end
end
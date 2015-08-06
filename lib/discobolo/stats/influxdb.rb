require 'influxdb'

module Discobolo
  module Stats
  	class Influxdb 

      attr_reader :client

      def initialize(opts={})
        @client = InfluxDB::Client.new("discobolo_stats", opts) #host: "influxdb.domain.com"
      end

      def setup
        begin
          @client.create_database("discobolo_stats") 
        rescue => e
          puts "influxdb #{e.exception}, all good"
        end
      end

      def add(jobid, opts={})
        data = {
          values: { value: jobid },
          tags: { queue: opts[:tag] }
        }
        @client.write_point(opts[:name], data)
      end

      def get_points
        #sql = "SELECT COUNT(value) FROM processed, failed WHERE time > now() - 1s GROUP BY time(1500ms)"
        #sql  = "SELECT COUNT(value) FROM processed, failed WHERE time > now() - 18m GROUP BY time(1s)"
        sql = "SELECT count(value) FROM /.*/ WHERE time > now() - 1s limit 1"
        @client.query(sql)
      end

      def get_history
        sql = "SELECT COUNT(value) FROM processed, failed WHERE time > now() - 10w GROUP BY time(1d)"
        @client.query(sql)
      end


    end
  end
end
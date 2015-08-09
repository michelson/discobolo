require "thor/group"

module Discobolo

  class CLI < Thor
    include Thor::Actions
    no_tasks {
      def cli_error(message, exit_status=nil)
        $stderr.puts message
        exit_status = STATUS_TYPES[exit_status] if exit_status.is_a?(Symbol)
        exit(exit_status || 1)
      end
    }

    map %w(--version -v) => 'version'
    desc "info", "information about Discobolo."
    def info
      require 'discobolo/version'
      say "Version #{::Discobolo::VERSION}"
    end

    map %w(--start -s) => 'start'
    desc "start", "start discobolo application"
    def start
      
      Discobolo::Config.setup do |config|
        config.client = ["127.0.0.1:7711"]
        config.stats = :influxdb
        config.queues = ["default", "important", "bogus"]
        config.fetch_options = {count: 10, timeout: 2000}
      end

      client = Discobolo::Config.client
      app = Discobolo::Application
      app.run
      
    end

    map %w(--status) => 'status'
    desc "status", "information about Discobolo Workers."
    def status
      s = Discobolo::SocketClient.new("/tmp/discobolo_stats")
      workers = s.echo("stats")
      s.finalize
    end

  end
end
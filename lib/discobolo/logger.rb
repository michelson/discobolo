module Discobolo

  class Logger < Logger
    def format_message(severity, timestamp, progname, msg)
      #puts timestamp
      #puts progname
      "#{severity} [#{timestamp}]: #{msg}\n".send(colorize(severity))
    end

    def colorize(severity)
      case severity
      when "ERROR"
        :red
      when "INFO"
        :green
      when "WARN"
        :yellow
      end
    end
  end
end
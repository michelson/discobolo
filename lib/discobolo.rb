
require "disque"
require "celluloid"
require "json"
require 'core_ext/string/color'

module Discobolo
  autoload :VERSION,    "discobolo/version.rb"
  autoload :Logger,     "discobolo/logger"
  autoload :Stats,      "discobolo/stats"
  autoload :Config,     "discobolo/config"
  autoload :Client,     "discobolo/client"
  autoload :Supervisor, "discobolo/supervisor"
  autoload :Actor,      "discobolo/actor"
  autoload :Worker,     "discobolo/worker"
  autoload :Application,"discobolo/application"
end



require "disque"
#require "celluloid"
require 'celluloid/current'
require "json"
require 'core_ext/string/color'

module Discobolo
  autoload :VERSION,      "discobolo/version.rb"
  autoload :Logger,       "discobolo/logger"
  autoload :Socket,       "discobolo/socket"
  autoload :SocketClient, "discobolo/socket_client"
  autoload :Stats,        "discobolo/stats"
  autoload :Config,       "discobolo/config"
  autoload :Client,       "discobolo/client"
  autoload :Supervisor,   "discobolo/supervisor"
  autoload :Fetcher,      "discobolo/fetcher"
  autoload :Actor,        "discobolo/actor"
  autoload :Worker,       "discobolo/worker"
  autoload :Application,  "discobolo/application"
end
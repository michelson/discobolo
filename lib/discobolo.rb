
require "disque"
require "celluloid"
require "json"

module Discobolo
  autoload :VERSION, 'discobolo/version.rb'
  autoload :Config, "discobolo/config"
  autoload :Supervisor, "discobolo/supervisor"
  autoload :Actor, "discobolo/actor"
  autoload :Worker, "discobolo/worker"
  autoload :Application, "discobolo/application"
end
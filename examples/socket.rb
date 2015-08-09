#!/usr/bin/env ruby                                                                                                                         

require 'socket'                                                                                                                            

socket = UNIXSocket.new("/tmp/discobolo_stats")

socket.puts("stats")



=begin
# s = Discobolo::Socket.new
# socket = UNIXSocket.new("/tmp/discobolo_stats")
# socket.puts("stats")
require "celluloid/current"

class MyActor 
  include Celluloid
  def initialize(args)
    puts "hello"
    async.fetch if args[:fetch]
  end

  def fetch
    loop do 
      #puts "fetching endlessly"
      #endless thing
    end
  end
end

class Supervisor < Celluloid::Supervision::Container
  #pool MyActor, as: :discobolo_pool, size: 5, 
  #  args: [{ fetch: true }]

    (1..5).each do |c|
      supervise type: MyActor, 
                as: :"discobolo_#{c}", 
                args: [{fetch: true}]
    end

end

@actor = Thread.new { Supervisor.run! }

#THIS WORKS FINE
puts @actor.registered_name
puts @actor.instance_variables
puts @actor.actors
puts @actor.state
puts @actor.size

#THIS IS BLOCKING
puts @actor
=end

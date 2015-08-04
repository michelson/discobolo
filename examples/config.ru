

require 'discobolo/web'

require "./boot"

map '/disque' do
  run Discobolo::Web
end
# Discobolo (WIP)

Ruby worker system for [disque](https://github.com/antirez/disque)

##Usage:

### Setup application:

```ruby
# Configure Discobolo 

Discobolo::Config.setup do |config|
  config.client = ["127.0.0.1:7711"]
  config.queues = ["default", "important", "bogus"]
  config.fetch_options = {count: 10, timeout: 2000}
  config.stats = :influxdb
  config.actor_concurrency = 5
  config.logger = $stdout # or filepath.log
end

# Run Application:

Discobolo::Application.run
```

### Implement a Worker: 

```ruby

class MyWorker < Discobolo::Worker
  set_queue "bogus"

  def perform(*args)
    # Do the hard work here
  end
end
```

### Enqueue

```ruby
DefaultWorker.enqueue({foo:bar})
```

## Web interface:

```ruby
#config.ru

require 'discobolo/web'

require "./your_disque_app"

map '/disque' do
  run Discobolo::Web
end

```
### Run rack appplication:

`bundle exec rackup`

visit http://localhost:4567


## Stats

The default stats system uses InfluxDB, so you have to install it in order to Discobolo display metrics in web panel.

to create another stats library you have to inherit from `Discobolo::Stats`
the class have to respond to some methods in order to work:

```
initialize
setup
add
get_points
get_history
```

See discobolo/stats/influxdb.rb for more information.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michelson/discobolo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


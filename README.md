# Discobolo (WIP)

Ruby worker system for [disque](https://github.com/antirez/disque)

##usage:

### Setup application:

```ruby
# Configure Discobolo 

Discobolo::Config.setup do |config|
  config.client = ["127.0.0.1:7711"]
  config.queues = ["default", "important", "bogus"]
  config.fetch_options = {count: 10, timeout: 2000}
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michelson/discobolo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


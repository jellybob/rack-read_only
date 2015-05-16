# Rack::ReadOnly

This gem allows Rack based APIs to be set to read only. At the most basic
it can be used like this from your `config.ru`:

```ruby
require 'rack/read_only'

use Rack::ReadOnly, {
  active: ENV["READ_ONLY"] == "1",
  response_body: '{ "error": "This API is currently in read only mode." }'
}
run MyApp
```

When in read only mode the API will continue to respond to GET, HEAD, and
OPTIONS requests as normal, but reject POST, PUT, DELETE, and PATCH requests
with the body specified, and a 503 error code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-read_only'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-read_only

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/jellybob/rack-read_only/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# HealthInspector
[![Build Status](https://api.travis-ci.org/cmthakur/health-inspector.svg?branch=master)](http://travis-ci.org/cmthakur/health-inspector)
[![Code Climate](https://codeclimate.com/github/cmthakur/health-inspector.svg)](https://codeclimate.com/github/cmthakur/health-inspector)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'health-inspector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install health-inspector

## Usage

    require 'health_inspector'
    HealthInspector.inspect!

## Development

  - Checkout out the repo
  - Run `bin/setup` to install dependencies
  - Run `./configure` to copy sample monitor.yml file
  - Run `rake spec` to run the tests
  - Run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Example `monitor.yml` file

```
  ---
  application: health-inspector
  framework: sinatra
  dependencies:
    - pg
    - redis
  services:
    postgres:
      name: 'PostgreSql'
      config:
        adapter: postgresql
        host: localhost
        username: postgres
        database: media_vision_dev
        password:

    redis:
      name: 'RedisServer'
      config:
        host: 'localhost'
        port: 6379
        db: 10
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cmthakur/health-inspector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HealthInspector project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/health_inspector/blob/master/CODE_OF_CONDUCT.md).

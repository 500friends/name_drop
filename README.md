[![Gem Version](https://img.shields.io/gem/v/name_drop.svg?style=flat)](https://rubygems.org/gems/name_drop)
[![Build Status](https://travis-ci.org/500friends/name_drop.svg?branch=master)](https://travis-ci.org/500friends/name_drop)
[![Test Coverage](https://codeclimate.com/github/500friends/name_drop/badges/coverage.svg)](https://codeclimate.com/github/500friends/name_drop/coverage)
[![Code Climate](https://codeclimate.com/github/500friends/name_drop/badges/gpa.svg)](https://codeclimate.com/github/500friends/name_drop)
[![Dependency Status](https://gemnasium.com/badges/github.com/500friends/name_drop.svg)](https://gemnasium.com/github.com/500friends/name_drop)
[![Inline docs](http://inch-ci.org/github/500friends/name_drop.svg?branch=master)](http://inch-ci.org/github/500friends/name_drop)

# NameDrop

NameDrop provides a ruby interface to the [Mention API](https://dev.mention.com/current/index.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'name_drop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install name_drop
## Configuration
Add an initializer file
(In rails typically you would name the file: config/initializers/name_drop.rb)

```ruby
NameDrop.configure do |config|
  config.account_id = ENV['MENTION_API_ACCOUNT_ID']
  config.access_token = ENV['MENTION_API_ACCESS_TOKEN']
end
```


## Usage

Creating a client
```ruby
client = NameDrop::Client.new
```

Fetching all objects
```ruby
all_alerts = client.alerts.all
```

Fetching single object
```ruby
alert = client.alert.find(mention_alert_id)
```

Create object
```ruby
alert = client.alert.build(new_attributes_hash)
alert.save
```

Update object
```ruby
alert = client.alert.find(mention_alert_id)
alert.attributes = updated_attributes_hash
alert.save
```

Destroy object
```ruby
shares = client.share.all(alert_id: 1)
shares.each do |share|
  share.destroy
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/500friends/name_drop. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


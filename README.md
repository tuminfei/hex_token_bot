# HexTokenBot

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hex_token_bot`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hex_token_bot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hex_token_bot
    
copy config YML to Rails

    bots.yml
    data_channels.yml
    tran_channels.yml
    tran_users.yml
    
create init setup file

````ruby
HexTokenBot.bots_yml = {
    :file_bots => Rails.root.join("config/bots/bots.yml"),
    :file_data_channels => Rails.root.join("config/bots/data_channels.yml"),
    :file_tran_channels => Rails.root.join("config/bots/tran_channels.yml"),
    :file_tran_users => Rails.root.join("config/bots/tran_users.yml")
}
````
   
## CLI

    hex_token_bot -c /path/config/bots
    


## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hex_token_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HexTokenBot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hex_token_bot/blob/master/CODE_OF_CONDUCT.md).

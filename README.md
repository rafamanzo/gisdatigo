# Gisdatigo

Very opinionated automation for most of the gem update process for Rails applications managed with bundler. By updating them, running the tests and then committing them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gisdatigo', '~> 0.0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gisdatigo

Why I still consider this gem unstable (0.x.y)? Despite I've been using it for some years, I have still to hear from some independent user that it also works for him/her. If you are this person, please let me know!

## Usage

```
rake gistadigo:run
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rafamanzo/gisdatigo.


# guard-jruby-minitest

[![Gem Version](https://badge.fury.io/rb/guard-jruby-minitest.svg)](http://badge.fury.io/rb/guard-jruby-minitest)

Guard has been a great productivity booster when used in a TDD environment. However, JRuby makes TDD harder, if not impossible. It is due to the fact that, by default, every `run_on_modification` or `run_on_change` starts a new process, which incurs [the long JVM start time]. Some approaches have been attempted, such as [Drip] or [Nailgun].

This guard extension allows you to run all of your tests on JRuby without the initial start up cost every time. It loads all of your application files in advance, and reloads any that change. That way, when you run test, the JVM is already running, and your files have already been required.

Most of the configuration options available to `guard-minitest` work with this extension too.

This gem should work with Rails as well as Rack applications.

## Reloaders

Currently, `guard` runs the following reloaders sequentially when part of application is changed:

* `AppPathsReloader`: Reloads the application (non-test) code.
* `FactoryGirlReloader`: Reloads the `factory_girl` factories.
* `RailsReloader`: Reloads the entire application if the application is a Rails app.
* `TestPathsReloader`: Reloads the tests. This is the most tricky part because of the way `minitest` run tests.
* Your custom reloader, as long as it supports `run` method. You can do so by `Guard::JRubyMinitest.reloaders << YOUR_CUSTOM_RELOADER`

## Caveats

Reloading is not always clean and sometimes could lead to unpredictable results. In that case, it is best to exit and rerun `guard`.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-jruby-minitest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guard-jruby-minitest

## Usage

Create or add to the `Guardfile` by running the following command in your application directory:

    $ bundle exec guard init jruby-minitest

Then run `guard` like this:

    $ bundle exec guard

The first time the test runs in Guard, it will take some time. However, after that, it should be quite fast.

## Thank You

Many thanks to [guard-jruby-rspec] for the inspiration.

## Contributing

1. Fork it ( https://github.com/jackxxu/guard-jruby-minitest/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[the long JVM start time]: https://github.com/jruby/jruby/wiki/Improving-startup-time
[Drip]: https://github.com/ninjudd/drip/wiki/JRuby
[Nailgun]: https://github.com/jruby/jruby/wiki/JRubyWithNailgun
[guard-jruby-rspec]: https://github.com/jkutner/guard-jruby-rspec

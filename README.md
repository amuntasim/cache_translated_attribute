#Still under testing..
## CacheTranslatedAttribute

Cache translated attributes (facilitated by globalize3 gem) to reduce db call

## Installation

Add this line to your application's Gemfile:

    gem 'cache_translated_attribute'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cache_translated_attribute

## Usage

    cache_translated_attribute :name, :description

### Provided that  you have

    translate :name, :description

in your model.

#### Tested with redis backend. did not test with memcache. will do that later

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

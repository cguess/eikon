# Eikón

This is an implementation of the DHash image matching algorithm in pure Ruby, as described here
https://www.hackerfactor.com/blog/?/archives/529-Kind-of-Like-That.html. Its main use is reverse
image searching.

This library is fully types in Sorbet.

## Installation

This gem requires [libvips](https://www.libvips.org) for image processing and [ffmpeg](https://ffmpeg.org) for video work. On MacOS you can install them using [HomeBrew](https://brew.sh) quite easily. On Linux your distro's package manager should have them. On Windows it's probably more difficult, but I don't have access to a machine to test that.

Once both libraries are installed you can install the gem with one of the following methods:

Add this line to your application's Gemfile:

```ruby
gem 'eikon'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install eikon

## Usage

To process a still image and get a DHash
`Eikon.dhash_for_image("./test/images/00001.jpg")`

To process a video and get an array of DHashes:
`Eikon.dhash_for_video("./test/videos/pexels-ron-lach-7121125.mp4")`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/eikon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/eikon/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Eikon project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/eikon/blob/master/CODE_OF_CONDUCT.md).

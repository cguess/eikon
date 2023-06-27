source "https://rubygems.org"

# Specify your gem's dependencies in eikón.gemspec
gemspec

gem "rake", "~> 12.0"
gem "minitest", "~> 5.0"
gem "ruby-vips"
# gem "debugger"

gem "rubocop", "~> 1.27", require: false
gem "rubocop-rails", require: false # Rails specific styles
gem "rubocop-rails_config", require: false # More Rails stuff

gem "sorbet-static-and-runtime"

group :development do
  gem "tapioca", require: false
end

group :test do
  gem "ruby-prof", "~> 1.6"
end

gem "terrapin"


# typed: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "eikon"
require "minitest/autorun"
require "minitest/assertions"

class Minitest::Test
  def ensure_video_assets_exist
    # Checks if our test video exists, if not it pulls it from the web
    # We don't want people installing the gem and install a 150mb file too
    return if File.exist?("test/videos/pexels-ron-lach-7121125.mp4")

    puts "***Video test file not found, downloading now. This may take a minute on slower connections.***\n\n"
    `wget https://eikon-test-assets.s3.amazonaws.com/pexels-ron-lach-7121125.mp4 -O test/videos/pexels-ron-lach-7121125.mp4`
  end
end


module Minitest::Assertions
  # Borrowed from Rails: File activesupport/lib/active_support/testing/assertions.rb, line 19
  def assert_not(object, message = nil)
    message ||= "Expected #{mu_pp(object)} to be nil or false"
    assert !object, message # rubocop:disable Rails/AssertNot
  end

  def assert_not_nil(object)
    assert_not object.nil?, "Expected a non-nil object but received nil"
  end
end

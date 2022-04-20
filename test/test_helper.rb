# typed: true
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "eikon"
require "minitest/autorun"


require "minitest/assertions"
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
=======
>>>>>>> 5531db0 (initial commit)

# typed: true
require "test_helper"
require "byebug"

class ComparatorTest < Minitest::Test
  def test_different_images_should_produce_different_hashes
    dhash_1 = Eikon.dhash_for_file("./test/images/00001.jpg")
    dhash_2 = Eikon.dhash_for_file("./test/images/00003.jpg")

    distance = Eikon::Comparator.compare(dhash_1, dhash_2)
    assert_not_nil distance
  end
end
